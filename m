Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07105C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:46:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109520673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n7S4rCaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XLKO5Il9IkuVUqRCwfpZHzl+IV5xtevRqq+TCDK1jmY=; b=n7S4rCaUqisP2w
	sGjHk9FLhzzN/YTix3v4y4LwgQRfuYMXv4af+puoFIqV9f2lpOJqvNhHwQ/sg0JzQxAVNzRh0e6rm
	XIx7poddX7SsNBkmFB8b/BKl2ocj9vw3bfEv58dGXdPqKH9tOVqNf1vrRgGl+bNygMYu+o2PLkbtL
	aGyOuza/rO+1YhW4CsR0NdT6m3Khf1d9TB+7m/NzZRjUQz1ROcxde1t6qHBQshOkZPgUZ0UaqnFrv
	JiPDZ/ht2ouktiGq/VrtmU0vwe7bNA9+sBzAdKH2xZ6NbtLhmw1uoyEsn3cDla7f5tgmsw7ZMaFtT
	GkdKxR0vK6V8ZMj6OMWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmsM-00061M-SM; Fri, 30 Nov 2018 17:46:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmsJ-00060t-93
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:46:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CAA4F20711; Fri, 30 Nov 2018 18:46:34 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 926F9209A7;
 Fri, 30 Nov 2018 18:46:24 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH RESEND] arm64: dts: clearfog-gt-8k: enable mini-PCIe CON2
 USB
References: <0336903e29be69d70a4dfc3b243d7134fba67ade.1539925074.git.baruch@tkos.co.il>
Date: Fri, 30 Nov 2018 18:46:24 +0100
In-Reply-To: <0336903e29be69d70a4dfc3b243d7134fba67ade.1539925074.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Fri, 19 Oct 2018 07:57:54 +0300")
Message-ID: <87bm66mpan.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_094647_447197_D843CCE2 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Russell King <linux@armlinux.org.uk>, Ori Shemtov <ori.shemtov@solid-run.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Baruch,
 
 On ven., oct. 19 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Deassert the reset and wireless disable signals on the CON2 mini-PCIe
> socket. That allows the host to detect USB devices on the mini-PCIe
> socket.
>

Applied on mvebu/dt64

Thanks,

Gregory

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>
> Resend: forgot to Cc the ARM kernel list on previous submission. Sorry
> for the duplicate.
> ---
>  .../boot/dts/marvell/armada-8040-clearfog-gt-8k.dts  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 73df0ef5e0c4..c2e53b4edb0c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -246,6 +246,18 @@
>  		gpios = <1 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  	};
> +
> +	lte_reset {
> +		gpio-hog;
> +		gpios = <2 GPIO_ACTIVE_LOW>;
> +		output-low;
> +	};
> +
> +	lte_disable {
> +		gpio-hog;
> +		gpios = <21 GPIO_ACTIVE_LOW>;
> +		output-low;
> +	};
>  };
>  
>  &cp0_ethernet {
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
