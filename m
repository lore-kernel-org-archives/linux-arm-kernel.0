Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4B420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="en3W4EMX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfQqfC6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4B420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFGoMl5fqqJMyv9w9vmRuAFOMSCxy4W7LhfxwWjO86s=; b=en3W4EMXbMRmZm
	LdN9Y98Nmo7gozwm1PLgJOKGfOo4xIapt3SC7jgOrSC2F3JE/MyMpuZTgz8rP2xykEsDotdjc1DHj
	aY+LSw519UZzGpImJy8G4dq+N3jzFN8594M8fBc2CJICqHjhDqo8AllyzYdltrUX0tBqI+zL5JTpz
	2ZS8Rpf8ejiMT48U2fV4JOXLFdPYwsmJY0cutuVbyp6qPed/20BGOcwqr0VG4c+eVQXiTj0FXAY/g
	3WYFKbxcd9mjvdT4YdQprzKwGI5eTcYo7qJ0ZXLdrwQ0chRMpgHgZD+uUjp8jMUYeOVoFZUAzgSeJ
	b29c63Nl30IqmarC1orw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcpkK-00028i-2i; Fri, 28 Dec 2018 10:52:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcpkH-00026z-PS; Fri, 28 Dec 2018 10:52:03 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49C2120855;
 Fri, 28 Dec 2018 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545994310;
 bh=YMD8Y7qqjN5YLGBGcAL0Ti831VhaFHn4+KG/ablm9gU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sfQqfC6wDH1rs0tiGXLXjw4PvxxUj4w/Q+sSFlWKXHZDpfQs6uiF6RMESacyFBLjA
 dUxO7QBLsBQ1Z2U4A/PjqCwnodLl4PMqgHUkMdoES8394iTFr4J/jbnG67xNl9TS+A
 kFwj9JkvTGATNX5A5uHq+sTNry1XGd+v35hnRSsM=
Date: Fri, 28 Dec 2018 11:51:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH] usb: devio: update max count of DPs per interval for ISOC
Message-ID: <20181228105148.GA22073@kroah.com>
References: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_025201_842213_10173D33 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: devicetree@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 06:27:44PM +0800, Chunfeng Yun wrote:
> The host shall be able to accept and send up to 96 DPs for
> devices operating at Gen 2 speed.

Why?  What is this keeping from working properly today?

I need a much better changelog text here in order to be able to accept
this patch.

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/devio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index a75bc0b8a50f..82c16210e34c 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
>  		}
>  		for (totlen = u = 0; u < number_of_packets; u++) {
>  			/*
> -			 * arbitrary limit need for USB 3.0
> -			 * bMaxBurst (0~15 allowed, 1~16 packets)
> -			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
> -			 * sizemax: 1024 * 16 * 3 = 49152
> +			 * arbitrary limit need for USB 3.1 Gen2
> +			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
>  			 */
> -			if (isopkt[u].length > 49152) {
> +			if (isopkt[u].length > 98304) {

Are we going to have to keep bumping this up as speeds get faster and
faster?

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
