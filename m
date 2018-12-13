Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25890C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:01:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E792620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMBCyUkQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dMLyJ/20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E792620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+x1eLvwZIkfCGMUL/kZNT1hNhp/WPf+pzOTjFXieYI=; b=LMBCyUkQEqEyZg
	6+69bjqrupiVRinS6Vz+pxrAyuePCpmaB2EQmP3T9sjvo0V9uN1EZxgqikc4vKJ1rGI0rtsEiGNNS
	1tLKKXNWBAhXNij5Ehq+YytyAIfgfdZXV/06vLDuVzBIYYVgEgaO+OqjHUeSynJEqvHKRTSo54RBd
	PMZUpohRUXSy7Ip7MaTIgr3YhUpksK3l0pQmOeaxPXbAxvxcgM7ZrNIav4VyvNNtm3AVNZrywuTVv
	s6zIAXQoEBP/jOSRZQui2lK03rGB5VULHVOl4jCK4S46t5AltlurzPBh8PlsdR2pdMfvHhVLSBfHs
	5OXGoNLX2xto48HglW2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOkC-0001sE-Ds; Thu, 13 Dec 2018 11:01:28 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOk1-0001kA-2a; Thu, 13 Dec 2018 11:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9qIbvvG/9lDI0uuCNjYROMG8ASH47z9X4H8Zg0GgJhE=; b=dMLyJ/20SBZrUcdB7qY2/6Jeu
 KMy7yre+SRT/s1amlnFxPKoCI3hYLXWYrBQGbErxDh46P7PdfYvvZKeyp2U2Tk5u+puMh+KOnV4Tv
 WnxroXw5DBjoPJXIy+pG6KQD7Y1XgNwYzOOzCrNFe0gg+YRiOxISLjehWIVhDKwUSvdX0=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47708)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXOjN-0001ys-NR; Thu, 13 Dec 2018 11:00:37 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXOjI-0003nr-Vm; Thu, 13 Dec 2018 11:00:33 +0000
Date: Thu, 13 Dec 2018 11:00:29 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] tty: serial: don't do termios for BTIF
Message-ID: <20181213110029.GN30658@n2100.armlinux.org.uk>
References: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_030117_269982_7A19901F 
X-CRM114-Status: GOOD (  16.62  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sean Wang <sean.wang@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Roy Luo <cheng-hao.luo@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 02:24:03PM +0800, Ryder Lee wrote:
> The MediaTek BTIF controller doesn't need to set termios so add
> a new capability 'UART_CAP_NMOD' for the unsupported case.
> 
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250.h      | 1 +
>  drivers/tty/serial/8250/8250_port.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index ebfb0bd..2b9ba39 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -80,6 +80,7 @@ struct serial8250_config {
>  #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>  					 */
> +#define UART_CAP_NMOD	(1 << 18)	/* UART doesn't do termios */
>  
>  #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
>  #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c39482b..e4a69a0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -297,7 +297,7 @@
>  		.tx_loadsz	= 16,
>  		.fcr		= UART_FCR_ENABLE_FIFO |
>  				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> -		.flags		= UART_CAP_FIFO,
> +		.flags		= UART_CAP_FIFO | UART_CAP_NMOD,
>  	},
>  	[PORT_NPCM] = {
>  		.name		= "Nuvoton 16550",
> @@ -2663,6 +2663,11 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  	unsigned long flags;
>  	unsigned int baud, quot, frac = 0;
>  
> +	if (up->capabilities & UART_CAP_NMOD) {
> +		termios->c_cflag = 0;

So your port is limited to 5-bits and is unable to receive characters?
That's what a zero cflag means, and that's what you'll be telling
userspace here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
