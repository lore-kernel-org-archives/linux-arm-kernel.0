Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C092C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:36:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A93920578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qI8EnSfC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GZa7G211"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A93920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHKw+PNxhG4QRBmS3vIZfBadf9inUb8/uPKEwtdobYA=; b=qI8EnSfC7BGu8C
	8eKfmddw0/dOislmwwyYQihjrtWoOPUgB9G4pji2KpeeC4IGDMArtCIUPA3mVyDWaRHVKDQbXRgyG
	+ds/rA/f808+jkUe/tZcnNVFyaqk4GkT57LCi5KkVjd5UfTqTuZxVGfvjltKdWI6GWKDpFD8aPFYr
	cCuICsvc9yhi3tJukvA1LsTuQ79dKXcD61qNrVILtMA7DC2VpbjbdWPzerfZofSXsv/vyHaO+J9bF
	VCnkWpYFAWIGPb74wAzMQ/l2sUErvH7GbZcJZ8UOK1UplEwqF6j8kLg2D4w7laoe0c9Gpv8VEGoMx
	1tVyi5mmM3utzon9fY0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf1Ik-0002aI-EJ; Thu, 03 Jan 2019 11:36:38 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf1If-0002Z3-4w
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 11:36:36 +0000
Received: by mail-ed1-x541.google.com with SMTP id f23so28716176edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 03:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QAtjRvaGY6cRS3ni56CYD0MaMT/IHbIGtqMvGym9bEI=;
 b=GZa7G211sA/FTbB4phgN5+3yMqQw+7y22FSo8IL8H7K1VyzNvPfVuOGWr2O/gmfG3M
 rTQNpMkwwDgpvX4maVsBAG45c7x9bZ5ntE9WizumasF9PQjg4QfiVffJSuQhfNNHk7kP
 o2JlMpbtnk1oaUb9NK6K4LlUNpcFfW/xnHvOfn6nVVh5t1FQuMwgQtN6vb6KGh5f0Y/3
 em0kY+JDFWOsEha/CI0EM/g53zfKRMDWyQuSVQkrhjuU471/BnpfL7Jd1RbelZcuEpYR
 Quk76nYUmg9fKIezIwdOONOduGFsaxUfcD0ZGNHp38l2E394NbSG4ox8PU/cBb3/bZoq
 bSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QAtjRvaGY6cRS3ni56CYD0MaMT/IHbIGtqMvGym9bEI=;
 b=lBEGuqL58yzuwCWDy01b3R81orBnQWp+Pp/mvxYMFEcIYRbOdTMk2MxFHwfvW4X5uU
 L8wrrigpgBxQNQK+fwGqmk4ZeuFmxesp6A12hbPiGGn8qXjpYcq7xurS129NwFbXeqnf
 pLk8gvk37caJsyvdTLel0alJlFy3RZ8c4alRLdSnIpGYfTAHt2C3AvcSLcgIvtnx4ZpO
 94Tl46ncQH4VKsledNR53plMTq7mYy/x971h67ZiaZ6tlX6b6t4R189uChgprvLJxNdo
 TbtIAoYExRBDrCeUSe18AQVEQ0jWJfZ1SosX88csyck8HcCNxfixW6vbiL2cobu3GDnw
 Tl8A==
X-Gm-Message-State: AJcUukfkly3eEg4wZiiLydSm5BMbMf5NwmvuM7iXHQh7kni8yacbsrGF
 HdS7jxm9+zIEx06uhoZS8m0SJw==
X-Google-Smtp-Source: ALg8bN6hAOzEn5qVoiyiJC8q3KMF8SidMu7k5Xxng6Adr5eLQrH6ZyHB9zryX7sR3jFHCibqT0kfYg==
X-Received: by 2002:a17:906:35d9:: with SMTP id
 p25-v6mr24651212ejb.40.1546515390573; 
 Thu, 03 Jan 2019 03:36:30 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id p10-v6sm11544783ejn.39.2019.01.03.03.36.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 03:36:29 -0800 (PST)
Subject: Re: [PATCH 1/3] ARM: dts: Add support for Variscite DART-6UL board
To: Oliver Graute <oliver.graute@gmail.com>,
 linux-arm-kernel@lists.infradead.org
References: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <9f86c1a5-42a5-70d2-4b68-5a9e1a5c1b42@baylibre.com>
Date: Thu, 3 Jan 2019 12:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_033633_242114_5FB73FB4 
X-CRM114-Status: GOOD (  25.17  )
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
Cc: fabio.estevam@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olivier,

On 20/12/2018 15:28, Oliver Graute wrote:
> From: Oliver Graute <oliver.graute@gmail.com>
> 
> This patch adds support for the Variscite DART-6UL SoM

The subject says "board", but here you add the "UL-ULL" common dtsi.

Here should be only the "SoM" specific nodes,
please look at the arch/arm/boot/dts/imx6qdl-var-dart.dtsi and
arch/arm/boot/dts/imx6q-var-dt6customboard.dts files for the
namings and separations between the SoM and Board DTs.

Especially, all HW on the "SoM" must go in the SoM dtsi and
the hardware on the Variscite provided "Board" in the board dts.

For example, the display must be in the board, you could have some
board based on this SoM without a display for example.

WiFi/BT should go in the SoM, Ethernet in the SoM, but the ethernet
PHY in the board, because another board could use a different PHY.

For audio, the codec should go in the SoM, but the audio card node
should go in the board, since the routing is board specific because
the board could have some other HW behind like amplifier, ...

Finally, the "board" should be named "6ulcustomboard" because it's
the actual board name used by variscite :
https://www.variscite.com/wp-content/uploads/2017/12/VAR-6ULCustomboard-Schematics.pdf

Neil

> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> ---
>  .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 623 +++++++++++++++++++++
>  1 file changed, 623 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> new file mode 100644
> index 0000000..0bcb459
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * Copyright (C) 2015-2017 Variscite Ltd. - http://www.variscite.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 20000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		status = "okay";
> +	};
> +
> +	pxp_v4l2 {
> +		compatible = "fsl,imx6ul-pxp-v4l2", "fsl,imx6sx-pxp-v4l2", "fsl,imx6sl-pxp-v4l2";
> +		status = "okay";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		touch_3v3_regulator: touch_3v3_regulator {
> +			compatible = "regulator-fixed";
> +			regulator-name = "touch_3v3_supply";
> +			regulator-always-on;
> +			status = "okay";
> +		};
> +
> +		reg_sd1_vmmc: regulator_sd1_vmmc {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VSD_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		reg_gpio_dvfs: regulator-gpio {
> +			compatible = "regulator-gpio";
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-name = "gpio_dvfs";
> +			regulator-type = "voltage";
> +			gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +			states = <1300000 0x1 1400000 0x0>;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8731audio";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Jack",
> +			"Microphone", "Mic Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "RHPOUT",
> +			"Headphone Jack", "LHPOUT",
> +			"LLINEIN", "Line Jack",
> +			"RLINEIN", "Line Jack",
> +			"MICIN", "Mic Bias",
> +			"Mic Bias", "Mic Jack";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +		/*simple-audio-card,bitclock-inversion;*/
> +
> +		sound_master: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			system-clock-id = <2>;  /* WM8731_SYSCLK_MCLK */
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +
> +		user {
> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BACK>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		d16_led {
> +			gpios = <&gpio4 20 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	arm-supply = <&reg_arm>;
> +	soc-supply = <&reg_soc>;
> +	dc-supply = <&reg_gpio_dvfs>;
> +};
> +
> +&clks {
> +	/* ref_clk for micrel ethernet phy */
> +	rmii_ref_clk: rmii_ref_clk_grp {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "rmii-ref";
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <786432000>;
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-reset-gpios=<&gpio5 0 1>;
> +	phy-reset-duration=<100>;
> +	phy-reset-on-resume;
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +};
> +
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet2>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy1>;
> +	phy-reset-gpios=<&gpio1 10 1>;
> +	phy-reset-duration=<100>;
> +	phy-reset-on-resume;
> +	status = "okay";
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,rmii-reference-clock-select-25-mhz;
> +			clocks = <&rmii_ref_clk>;
> +			clock-names = "rmii-ref";
> +			reg = <1>;
> +		};
> +
> +		ethphy1: ethernet-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,rmii-reference-clock-select-25-mhz;
> +			clocks = <&rmii_ref_clk>;
> +			clock-names = "rmii-ref";
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	status = "disabled";
> +};
> +
> +&gpc {
> +	fsl,cpu_pupscr_sw2iso = <0x2>;
> +	fsl,cpu_pupscr_sw = <0x1>;
> +	fsl,cpu_pdnscr_iso2sw = <0x1>;
> +	fsl,cpu_pdnscr_iso = <0x1>;
> +	fsl,ldo-bypass = <0>; /* DCDC, ldo-enable */
> +};
> +
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif_dat
> +		     &pinctrl_lcdif_ctrl>;
> +	display = <&display0>;
> +	status = "okay";
> +
> +	display0: display {
> +		bits-per-pixel = <16>;
> +		bus-width = <24>;
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: timing0 {
> +				clock-frequency =<35000000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hfront-porch = <40>;
> +				hback-porch = <40>;
> +				hsync-len = <48>;
> +				vback-porch = <29>;
> +				vfront-porch = <13>;
> +				vsync-len = <3>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	vref-supply = <&touch_3v3_regulator>;
> +	status = "okay";
> +};
> +
> +&tsc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tsc>;
> +	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +	measure_delay_time = <0xffff>;
> +	pre_charge_time = <0xfff>;
> +	status = "disabled";
> +};
> +
> +/* Console UART */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* Bluetooth UART */
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +/* ttymxc2 UART */
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +};
> +
> +&usbotg1 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +/*  Wi-Fi/BT SD Card Slot Definition */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	assigned-clocks = <&clks IMX6UL_CLK_USDHC1_SEL>, <&clks IMX6UL_CLK_USDHC1>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
> +	assigned-clock-rates = <0>, <132000000>;
> +	fsl,tuning-step= <2>;
> +	vmmc-supply = <&reg_sd1_vmmc>;
> +	status = "okay";
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
> +	fsl,legacy-bch-geometry;
> +	status = "okay";
> +
> +	partition@0 {
> +		label = "spl";
> +		reg = <0x00000000 0x00200000>;
> +	};
> +
> +	partition@1 {
> +		label = "uboot";
> +		reg = <0x00200000 0x00200000>;
> +	};
> +
> +	partition@2 {
> +		label = "uboot-env";
> +		reg = <0x00400000 0x00200000>;
> +	};
> +
> +	partition@3 {
> +		label = "kernel";
> +		reg = <0x00600000 0x00800000>;
> +	};
> +
> +	partition@4 {
> +		label = "rootfs";
> +		reg = <0x00e00000 0x3f200000>;
> +	};
> +};
> +
> +&usdhc2 {
> +	status = "disabled";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock_frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	codec: wm8731@1a {
> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8731";
> +		reg = <0x1a>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +	};
> +
> +	ft5x06_ts@38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <4 0>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> +
> +	/* DS1337 RTC module */
> +	rtc@0x68 {
> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rtc>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_1>;
> +	imx6ul-evk {
> +		pinctrl_hog_1: hoggrp-1 {
> +			fsl,pins = <
> +				MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
> +				MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
> +				MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
> +				MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
> +				MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029
> +			>;
> +		};
> +
> +		pinctrl_enet1: enet1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +				MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +				MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +			>;
> +		};
> +
> +		pinctrl_enet2: enet2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
> +				MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
> +				MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
> +				MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
> +				MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
> +				MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
> +				MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
> +				MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
> +				MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_flexcan1: flexcan1grp{
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
> +				MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp{
> +			fsl,pins = <
> +				MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
> +				MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
> +			>;
> +		};
> +
> +		pinctrl_lcdif_dat: lcdifdatgrp {
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
> +				MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
> +				MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
> +				MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
> +				MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
> +				MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
> +				MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
> +				MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
> +				MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
> +				MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
> +				MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
> +				MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
> +				MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
> +				MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
> +				MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
> +				MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
> +				MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
> +				MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
> +			>;
> +		};
> +
> +		pinctrl_lcdif_ctrl: lcdifctrlgrp {
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
> +				MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
> +			>;
> +		};
> +
> +		pinctrl_pwm1: pwm1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> +				MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +				MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +				MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
> +				MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
> +				MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
> +				MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
> +				MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
> +				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +			fsl,pins = <
> +				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +			fsl,pins = <
> +				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_gpmi_nand_1: gpmi-nand-1 {
> +			fsl,pins = <
> +				MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
> +				MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
> +				MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
> +				MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
> +				MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
> +				MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0xb0b1
> +				MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
> +				MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
> +				MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
> +				MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
> +				MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
> +				MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
> +				MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
> +				MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
> +				MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
> +				MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
> +				MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
> +				MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
> +			>;
> +		};
> +
> +		pinctrl_tsc: tscgrp {
> +			fsl,pins = <
> +				MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
> +				MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
> +				MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
> +				MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
> +			>;
> +		};
> +
> +		pinctrl_sai1: sai1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_CSI_DATA05__SAI1_TX_BCLK	0x11088
> +				MX6UL_PAD_CSI_DATA04__SAI1_TX_SYNC	0x17088
> +				MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA	0x11088
> +				MX6UL_PAD_CSI_DATA07__SAI1_TX_DATA	0x11088
> +			>;
> +		};
> +
> +		pinctrl_sai2: sai2grp {
> +			fsl,pins = <
> +				MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +				MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +				MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +				MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +				MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +			>;
> +		};
> +
> +		pinctrl_wdog: wdoggrp {
> +			fsl,pins = <
> +				MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
> +			>;
> +		};
> +	};
> +};
> +
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
