Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCDDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED03521841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BkCW+nzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED03521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K52hR7y/4/qIdnwq9YBhO20JbukkooFw/3OCMpjQQKk=; b=BkCW+nzQmBEHZZ
	QB7FlQSPOLrqQGXfljfFj3ssmInX/KDTXkbBG12VUyuf0lZbZpMaCICs0Wkox34pj3E7wcoNhXCT9
	lJdlpGEii/PVoCqA8m0dc9j2/j8fan3uYhzGKCsEiEi0Jz8i8UcthGHCqcU4qf6+CeQBGGmlb7zHS
	EMYVrRJw2nbfU2fqxXanheHTPFmxnJ/079VBgoGMlgvg4uvmHO53b/J1ThS1WRMC9Ac7LbqIcM3oV
	NVyIgoQxd77iqxpPAZP+vCj+b4KwMOsMzilpw26YxlKzGRMuWGdCJssx52TP8QTQnDRerq8bFgVnA
	Ji3KPTnPHGlZFDdefRHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZVy4-0000jB-QB; Wed, 19 Dec 2018 07:08:32 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZVy1-0000iH-5l
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 07:08:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1E64E207D9; Wed, 19 Dec 2018 08:08:17 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id DAA33206A7;
 Wed, 19 Dec 2018 08:08:16 +0100 (CET)
Date: Wed, 19 Dec 2018 08:08:17 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Karl Palsson <karlp@tweak.net.au>
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
Message-ID: <20181219070817.crt4xi2itaigrioy@flea>
References: <20181218212457.30382-1-karlp@tweak.net.au>
 <20181218212457.30382-2-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218212457.30382-2-karlp@tweak.net.au>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_230829_485763_1485CFB1 
X-CRM114-Status: GOOD (  19.04  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 09:24:56PM +0000, Karl Palsson wrote:
> This is an Allwinner H3 based board, with 512MB ram, a USB OTG port,
> microsd slot, an onboard AP6212A wifi/bluetooth module, and a CSI
> connector.
> 
> Full details and schematic available from vendor:
> http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2
> 
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 148 +++++++++++++++++++++++++++++
>  2 files changed, 149 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 78551c4375d5..7f296bfea94a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1063,6 +1063,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-h3-beelink-x2.dtb \
>  	sun8i-h3-libretech-all-h3-cc.dtb \
>  	sun8i-h3-mapleboard-mp130.dtb \
> +	sun8i-h3-nanopi-duo2.dtb \
>  	sun8i-h3-nanopi-m1.dtb	\
>  	sun8i-h3-nanopi-m1-plus.dtb \
>  	sun8i-h3-nanopi-neo.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> new file mode 100644
> index 000000000000..07d2f1bebd56
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2018 Karl Palsson <karlp@tweak.net.au>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-h3.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "FriendlyARM NanoPi Duo2";
> +	compatible = "friendlyarm,nanopi-duo2", "allwinner,sun8i-h3";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		status {
> +			label = "nanopi:green:status";
> +			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		pwr {
> +			label = "nanopi:red:pwr";
> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	r_gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sw_r_npi>;
> +
> +		k1 {
> +			label = "k1";
> +			linux,code = <BTN_0>;
> +			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	reg_vdd_cpux: vdd-cpux-regulator {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd-cpux";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-ramp-delay = <50>; /* 4ms */
> +
> +		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +		enable-active-high;
> +		gpios-states = <0x1>;
> +		states = <1100000 0x0
> +			  1300000 0x1>;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> +	};
> +
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_vdd_cpux>;
> +};
> +
> +&usb_otg {
> +	status = "okay";
> +	dr_mode = "otg";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&reg_usb0_vbus {
> +	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> +	status = "okay";
> +};
> +
> +&r_pio {
> +	sw_r_npi: key_pins {
> +		pins = "PL3";
> +		function = "gpio_in";
> +	};
> +};

This node isn't needed you can just remove it

> +&usbphy {
> +	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +	vmmc-supply = <&reg_vcc3v3>;
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +
> +	sdio_wifi: sdio_wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>, <&uart2_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	/* bluetooth goes here */

The patches for the bluetooth support using serdev by Chen-Yu just got
in:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/621207.html

Ideally, you should put a dt node for the bluetooth part here.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
