Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A987C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9BE2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CO1LXYfL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvYpn7wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9BE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oNuIs5vRPfQG3m4/C6OgaxGXj4Uqllde8RLemOF9INk=; b=CO1LXYfLOOjmrO
	vMI6yv0JrfytbIhmpVfExlbkfoN+EhbKpvwt8Vq4BTA39Wh2jjlSxV7AplBmqM+pEdyFIoQbju8Ad
	tO31TcsRGn8jE3R7bY7XFwnfP/LZ9AL+1CeekuC1gYPZcZn7QFSN4eDE5z1Ta8N6mRGiGrwnBtV/s
	NRyE1vP4YFJihwvW9jFaQOsWZApBexx6ydop98c4zkDWPOrgat4O5yWYQ8Ued2XlwQmNox8uQxyn0
	+lDPTjt7QwFMzi4E/5ZDG305R2I2v/rgvTW/zwrdeFZgWmEuYvOKEeS3ltBKJzz/nBzxim/mBXAtt
	jw1qnvbHH+E6/v/F3crw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUO3x-0005RI-IW; Wed, 05 Dec 2018 03:41:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUO3u-0005Qp-Po
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:41:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74E862054F;
 Wed,  5 Dec 2018 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543981271;
 bh=apwjPlfTKPzyZiU3hJ6v+Db69mr2xX7jD2uohR6y3Xo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hvYpn7wdKxALFf1GfAwDPn3C42HAsTOqjXD9N9K2G6/Gt/uOqN3o1PIkNkjdBo0wK
 yKr8toVoxAlaucoLJvGiE0joJd3KNR3Lm5cEEbi5t/W/yFAIRKTWvBrAi8Hpxh9o8W
 2CUHNbmSGPBv8iwJIrXDfItysj/W/CRZX8VC7vFw=
Date: Wed, 5 Dec 2018 11:40:31 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
Message-ID: <20181205034029.GJ3987@dragon>
References: <1543504220-10870-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543504220-10870-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_194122_925927_1C43EB88 
X-CRM114-Status: GOOD (  16.61  )
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
Cc: linux-arm-kernel@lists.infradead.org, cphealy@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 01:10:20PM -0200, Fabio Estevam wrote:
> On the vf610-zii-scu4-aib board there is a hi8435 ( 32-channel
> discrete-to-digital SPI sensor device) in the DSPI0 bus.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index 52bac14..a1fd49e 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -397,6 +397,20 @@
>  	};
>  };
>  
> +&dspi0 {
> +	pinctrl-0 = <&pinctrl_dspi0>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	bus-num = <0>;

We usually put 'status' at the bottom of property list.

> +
> +	hi8435@5 {

Can we have a generic name for the device?

Shawn

> +		compatible = "holt,hi8435";
> +		reg = <5>;
> +		gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
>  &dspi1 {
>  	bus-num = <1>;
>  	pinctrl-names = "default";
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
