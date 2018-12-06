Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A93C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:35:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ABF208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnwRMnBj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkgAzdcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ABF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=38k9eEdNVfdILfp88qUkCaFqqEVVG9iYxKHBTOqzgD8=; b=rnwRMnBjBXCUgy
	BYXO2UgRd+au8lNydUdrtoCDvIc1isC4ljeDz38Xnj54EYPpI7Lwn519VeKn6CI0ozL8a+8h6N+Sj
	H/MS6NC2GsJGJAa8xxDkGFC54V4ZYU1KNaPxDXmluaYqR159Q1q+u+Hp3wf+AKBn9S50wlHg1qQPA
	APrO5iMO9PDzG1Wc9jHX67RYC7kClGtDsnpjuR4X3u4H9sDuoUggok3hrvGr0CntPM8e1fxgVfvkp
	zWxK2DWG+jM3kaKgE+3u8ZpDfZYUVKTG7lECsovePbMieECv3ySc+X9u9mHqVD0jUWL9tWFgWPCUY
	f8fC6LWD0ggr8kd6KuFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiZR-0004nB-O9; Thu, 06 Dec 2018 01:35:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiZL-0003TJ-SL
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:35:15 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9800D20892;
 Thu,  6 Dec 2018 01:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544060099;
 bh=WvHEc2BLCVEQoCTYhCUlbgy6Sx6/K3Hx/ILP0EL3YKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YkgAzdcGuKvJXlUvfqXHKASVe7GhginMzq18/MMbn3xE2wWll+kgxq9IPRuXDACkE
 wEH+eO3CcExTknR04N8/2sdkAkQ+c6DSanImrFQ3zAg24FgnvD5cEYZLxA/mHJTp2n
 IIr6wSBLl7vyMaJm6D/vUl7zdDPqhdeO6QYeImA8=
Date: Thu, 6 Dec 2018 09:34:20 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 4/5] ARM: dts: imx6ul-pico-hobbit: Extend peripherals
 support
Message-ID: <20181206013419.GT3987@dragon>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
 <20181202211809.11621-5-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202211809.11621-5-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_173511_934547_4913C7A5 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 07:18:08PM -0200, Otavio Salvador wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> This adds following peripherals support:
> 
>  - ADC
>  - GPIO LED
>  - GPIOs
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> index 8656ccbb5a06..f2dd6945e98c 100644
> --- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> +++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> @@ -14,6 +14,8 @@
>  
>  	leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
>  
>  		led {
>  			label = "gpio-led";
> @@ -58,6 +60,12 @@
>  &i2c3 {
>  	status = "okay";
>  
> +	adc081c: adc@50 {
> +		compatible = "ti,adc081c";
> +		reg = <0x50>;
> +		vref-supply = <&reg_3p3v>;
> +	};
> +

The child nodes should be sorted in order of unit-address.  That said,
it should go after touchscreen@38 below.

I fixed it up and applied the series.

Shawn

>  	polytouch: touchscreen@38 {
>  		compatible = "edt,edt-ft5x06";
>  		reg = <0x38>;
> @@ -68,3 +76,25 @@
>  		touchscreen-size-y = <480>;
>  	};
>  };
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0
> +			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0
> +			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0
> +			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0
> +			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x10b0
> +			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x10b0
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledsgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x10b0
> +		>;
> +	};
> +};
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
