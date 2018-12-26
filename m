Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:18:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B3020C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YLnfWG8E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwutEstZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B3020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xu/9M6FGNuG9R65DpsSmIWo89sMPiOGgOHRbP88AM18=; b=YLnfWG8EVXZ7BB
	iygYcALTRz3sCeO812XGT1a/wzOjr5BefQDq7cNjgnWKkD/gz27XgZ38HN4BiFF5voZqow7eniRQS
	LOEUVmBVx7KN7sngg64lyEMTbkQq4EBQB8N0S6vHGMh0vV+4U5o6Knrz9OrIp2q1EeWiTT2pSyYjN
	tzWMxRz2+Pr2KBSz0IlBVaQ1C0M1uAqOuNUDlNMI92pP8pq2FpudAUqlqkPCmiG9mWDP6XjWnTLFm
	Z8Pm46VkB3P43Pu8KgyHVwN+E4XgZhGi8GwbQINgwxSFiSblQw62obnsOEG3zIOL23pff4aYWli2r
	p+fKZbWOfeqp+93kirfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcBt0-0003XJ-NK; Wed, 26 Dec 2018 16:18:22 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcBsw-0003G2-Rr
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:18:20 +0000
Received: by mail-ot1-x343.google.com with SMTP id 81so14350033otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tXSZBRI9K5mbfjkd3Fuw7hcIJ1r9xo7DACQysBsbq94=;
 b=QwutEstZTd7FC9qrw3PEg9B5kb6Rk7Vcr2b+QOUH2zJOf9o8W6Uh+0tTEbVD0TCiAn
 hIBCau8t3QJEBMf4J5XeQXfYsQkTYE9liXnfOgq2zGR3xQyjsK3i13XUt214BNiYKpOs
 GdIC6Hk8o4Vu5XhKMN6gRGKZzkjq4DxKEj/meS9bUBKkPy88m1LoXYp1V/kTbwEV4NzW
 mvwrctCvsNmSYeQtbzJmRd2zlBJettSOPd4IbVQKAtl2eKjL5G13x7Gg6+B6BAKqG5SH
 AjmLog1c6XA/raJeEPTQENlr+EYn7sEkm1zArrJqzCe12U1DUsgF5QDjnCEdFsXG5ZAg
 pemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tXSZBRI9K5mbfjkd3Fuw7hcIJ1r9xo7DACQysBsbq94=;
 b=F1YpknRRXWEyT9lxY4diidUqnKDXSgxz5c1kq+T7+NDSw0lybL6p6dpSFkyptq8aUe
 onPgqiD4WDqDleJ/wmANz318fREm+GaLE/7hIyYHY8+zBkMq92bgrmMvQDEvXyhJ067i
 WX3uhCPBaycKQs/L6G6A0LBJdVauJeA3Y45Fgui4dxrcrIs4sYDKrUZwz7wv3HFoBILP
 7AbSLIieu6jydEi9g/mpKVmBsZtVjfyB91wfoG7vrngUMwYCO1GiBwOYWGWnlodCXTVb
 ryPl/DF0hkFy82cprZF1PonM/dxHSCowiOS3X43Y4fqYE7i462Ltw+Y/A554NTtUcY45
 c0IQ==
X-Gm-Message-State: AJcUukfVDsOLsNJOUqY1+FRn7fJovj6XsMrd5HkDWCNd1PexJ1UtSUVD
 PDhkycxGd57DLkfftNTqPig7kDfg3bFVkjOMgIs3oXqt
X-Google-Smtp-Source: ALg8bN7/WAsn30geieXLIfEX5MMU6samF1CrdYLa6xEIx0Ey8ZwhErexY6UNWGowN6XDxzA84izv0mavs396V9J3ViU=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr14645788otq.255.1545841087292; 
 Wed, 26 Dec 2018 08:18:07 -0800 (PST)
MIME-Version: 1.0
References: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
In-Reply-To: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Dec 2018 14:18:13 -0200
Message-ID: <CAOMZO5CF5uYDm_XM8m-+9ARQPsxVqNqUJuuHwEF-CRu2DNDOdQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add support for Variscite DART-6UL board
To: Oliver Graute <oliver.graute@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_081818_906384_8403B15F 
X-CRM114-Status: GOOD (  27.27  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Oliver,

On Thu, Dec 20, 2018 at 12:29 PM Oliver Graute <oliver.graute@gmail.com> wrote:
>
> From: Oliver Graute <oliver.graute@gmail.com>
>
> This patch adds support for the Variscite DART-6UL SoM
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

As you added the SPDX identifier you could simply remove this paragraph.

> + */
> +
> +/ {
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       memory {

You need to pass "device_type = "memory";"

> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pwm1 0 20000>;
> +               brightness-levels = <0 4 8 16 32 64 128 255>;
> +               default-brightness-level = <6>;
> +               status = "okay";
> +       };
> +
> +       pxp_v4l2 {
> +               compatible = "fsl,imx6ul-pxp-v4l2", "fsl,imx6sx-pxp-v4l2", "fsl,imx6sl-pxp-v4l2";
> +               status = "okay";
> +       };

This compatible does not exist in mainline, so please remove it.

> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               touch_3v3_regulator: touch_3v3_regulator {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "touch_3v3_supply";
> +                       regulator-always-on;
> +                       status = "okay";
> +               };

regulators should not be places under "simple-bus".

Move it outside and name it like:

 touch_3v3_regulator: regulator-touch-3v3 {


> +
> +               reg_sd1_vmmc: regulator_sd1_vmmc {

reg_sd1_vmmc: regulato-rsd1-vmmc


> +                       compatible = "regulator-fixed";
> +                       regulator-name = "VSD_3V3";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +               };
> +
> +               reg_gpio_dvfs: regulator-gpio {
> +                       compatible = "regulator-gpio";
> +                       regulator-min-microvolt = <1300000>;
> +                       regulator-max-microvolt = <1400000>;
> +                       regulator-name = "gpio_dvfs";
> +                       regulator-type = "voltage";
> +                       gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +                       states = <1300000 0x1 1400000 0x0>;
> +               };
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "wm8731audio";
> +               simple-audio-card,widgets =
> +                       "Headphone", "Headphone Jack",
> +                       "Line", "Line Jack",
> +                       "Microphone", "Mic Jack";
> +               simple-audio-card,routing =
> +                       "Headphone Jack", "RHPOUT",
> +                       "Headphone Jack", "LHPOUT",
> +                       "LLINEIN", "Line Jack",
> +                       "RLINEIN", "Line Jack",
> +                       "MICIN", "Mic Bias",
> +                       "Mic Bias", "Mic Jack";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,bitclock-master = <&sound_master>;
> +               simple-audio-card,frame-master = <&sound_master>;
> +               /*simple-audio-card,bitclock-inversion;*/

Remove  the property instead of commenting it out.
> +
> +               sound_master: simple-audio-card,cpu {
> +                       sound-dai = <&sai2>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&codec>;
> +                       system-clock-id = <2>;  /* WM8731_SYSCLK_MCLK */

This property does not exist in mainline.

> +                       system-clock-frequency = <12288000>;
> +               };
> +       };
> +
> +       keys {
> +               compatible = "gpio-keys";
> +
> +               user {
> +                       gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_BACK>;
> +                       gpio-key,wakeup;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               d16_led {
> +                       gpios = <&gpio4 20 0>;

Please use GPIO_ACTIVE_HIGH instead of 0.

> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +};
> +
> +&cpu0 {
> +       arm-supply = <&reg_arm>;
> +       soc-supply = <&reg_soc>;
> +       dc-supply = <&reg_gpio_dvfs>;

This property does not exist in mainline.

> +
> +&clks {
> +       assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +       assigned-clock-rates = <786432000>;
> +};
> +
> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet1>;
> +       phy-mode = "rmii";
> +       phy-reset-gpios=<&gpio5 0 1>;

GPIO_ACTIVE_LOW

> +       phy-reset-duration=<100>;
> +       phy-reset-on-resume;

This property does not exist in mainline.

> +       phy-handle = <&ethphy0>;
> +       status = "okay";
> +};
> +
> +&fec2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet2>;
> +       phy-mode = "rmii";
> +       phy-handle = <&ethphy1>;
> +       phy-reset-gpios=<&gpio1 10 1>;

GPIO_ACTIVE_LOW

> +       phy-reset-duration=<100>;
> +       phy-reset-on-resume;

This property does not exist in mainline.

> +       status = "okay";

Add an empty line here

> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;

> +&gpc {
> +       fsl,cpu_pupscr_sw2iso = <0x2>;
> +       fsl,cpu_pupscr_sw = <0x1>;
> +       fsl,cpu_pdnscr_iso2sw = <0x1>;
> +       fsl,cpu_pdnscr_iso = <0x1>;
> +       fsl,ldo-bypass = <0>; /* DCDC, ldo-enable */

None of these properties exist.

> +};
> +
> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lcdif_dat
> +                    &pinctrl_lcdif_ctrl>;
> +       display = <&display0>;
> +       status = "okay";
> +
> +       display0: display {
> +               bits-per-pixel = <16>;
> +               bus-width = <24>;
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency =<35000000>;
> +                               hactive = <800>;
> +                               vactive = <480>;
> +                               hfront-porch = <40>;
> +                               hback-porch = <40>;
> +                               hsync-len = <48>;
> +                               vback-porch = <29>;
> +                               vfront-porch = <13>;
> +                               vsync-len = <3>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <0>;

Don't add timing parameters in the device tree. Add the panel support
in the simple panel driver and use the drm mxsfb bindings.

> +
> +&tsc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_tsc>;
> +       xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +       measure_delay_time = <0xffff>;
> +       pre_charge_time = <0xfff>;

These two properties do not exist.

> +       status = "disabled";
> +};
> +
> +/* Console UART */
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +       status = "okay";
> +};
> +
> +/* Bluetooth UART */
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       fsl,uart-has-rtscts;

Use "uart-has-rtscts" instead.

> +       status = "okay";
> +};
> +
> +/* ttymxc2 UART */
> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart3>;
> +       fsl,uart-has-rtscts;

Ditto.

> +       status = "okay";
> +};
> +
> +&wdog1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdog>;
> +       fsl,ext-reset-output;
> +};

Keep the node names sorted . Except iomuxc that can go as the last one.

> +&gpmi {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpmi_nand_1>;
> +       fsl,legacy-bch-geometry;
> +       status = "okay";
> +
> +       partition@0 {
> +               label = "spl";
> +               reg = <0x00000000 0x00200000>;
> +       };
> +
> +       partition@1 {
> +               label = "uboot";
> +               reg = <0x00200000 0x00200000>;

The unit address and reg values do not match. This would trigger a dtc
warning if you build it with W=1.

Please make sure that you get no  dtc warning in v2

> +       };
> +
> +       partition@2 {
> +               label = "uboot-env";
> +               reg = <0x00400000 0x00200000>;
> +       };
> +
> +       partition@3 {
> +               label = "kernel";
> +               reg = <0x00600000 0x00800000>;
> +       };
> +
> +       partition@4 {
> +               label = "rootfs";
> +               reg = <0x00e00000 0x3f200000>;
> +       };
> +};
> +
> +&usdhc2 {
> +       status = "disabled";

This node is already disabled in the dtsi.


> +};
> +
> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       clock_frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       codec: wm8731@1a {

Node names should be generic and label names should be specific, so:

wm8731: codec@1a


> +               #sound-dai-cells = <0>;
> +               compatible = "wlf,wm8731";
> +               reg = <0x1a>;
> +               clocks = <&clks IMX6UL_CLK_SAI2>;
> +               clock-names = "mclk";
> +       };
> +
> +       ft5x06_ts@38 {

touchscreen@38


> +               compatible = "edt,edt-ft5x06";
> +               reg = <0x38>;
> +               interrupt-parent = <&gpio3>;
> +               interrupts = <4 0>;
> +               touchscreen-size-x = <800>;
> +               touchscreen-size-y = <480>;
> +               touchscreen-inverted-x;
> +               touchscreen-inverted-y;
> +       };

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog_1>;
> +       imx6ul-evk {

There is no need for this imx6ul-evk. Just place the pinctrl nodes
outside of it.


> +               pinctrl_hog_1: hoggrp-1 {
> +                       fsl,pins = <
> +                               MX6UL_PAD_CSI_HSYNC__GPIO4_IO20         0x1b0b0
> +                               MX6UL_PAD_GPIO1_IO00__GPIO1_IO00        0x17059

These should go to the LED pinctrl group instead of hog.


> +                               MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
> +                               MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0

This should go to enet2 pin group instead of hog.


> +                               MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029

Is this for Wifi? If so you could add a pwrseq entry that could take care of it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
