Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEAC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:01:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C546D2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmiyz4cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C546D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wPAb56fKG/PnTG3MZKpLXVdJ9SYqwvirB2EeudjTH6c=; b=kmiyz4cT7YOBTB
	24WiQ7w9kGuCOtGst2pIk47z1VAYZaTQjN4sapja/e6e0q6zb/47SM6UQaP4xN3CY4/DHpv7pmpJx
	WxW9ReYuBuG1h5Zoybd9QNEip9N8SO4WBD46/S4n6KdYsCOF87sM3sVZPDfZjQlSdPp4RM/wCeJvo
	l3s9eo1OqP61anFeMA/v9ZZoURQHF9j5eX/H/s5SOmkLsn+Dyngp4IEn2d4g1U1d0PVVUoTCbf8+g
	t+VMvGY3JeiY8q+sX9aRtng7SOKb3bAVDxnWUM+RuNzHZ6X3pTMMYeHygVYGQD1tlX8sDMOcq/nQm
	WCENFZN27W2W5i3S1kfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn6n-0007fE-Ga; Fri, 30 Nov 2018 18:01:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn6d-0007eG-W4
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:01:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7FE4320711; Fri, 30 Nov 2018 19:01:24 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 34F7520D0D;
 Fri, 30 Nov 2018 19:01:14 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] arm64: dts: add support for Macchiatobin Single Shot board
References: <E1gJidB-0000XQ-Ua@rmk-PC.armlinux.org.uk>
Date: Fri, 30 Nov 2018 19:01:14 +0100
In-Reply-To: <E1gJidB-0000XQ-Ua@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 05 Nov 2018 17:25:41 +0000")
Message-ID: <87zhtqla1h.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100141_607011_2F2D2E29 
X-CRM114-Status: GOOD (  25.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 John Nettleton <jon@solid-run.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Russell,
 
 On lun., nov. 05 2018, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Add DT support for the Macchiatobin Single Shot board from SolidRun,
> which is similar to the Double Shot board, but does not have the
> 10G 3310 PHYs - the two ethernet ports are instead connected directly
> to the SFP+ cages.
>


Applied on mvebu/dt64 so it can be in linux-next, but for now mvebu/dt64
is not immutable, so if we see an issue it still time to remove it.

Thanks,

Gregory

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> If you'd like me to generate this patch with -C to better show the
> changes in the .dtsi, please just ask.
>
>  arch/arm64/boot/dts/marvell/Makefile               |   1 +
>  .../dts/marvell/armada-8040-mcbin-singleshot.dts   |  29 ++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 333 +-------------------
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 346 +++++++++++++++++++++
>  4 files changed, 380 insertions(+), 329 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
>
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index eca8bac6303a..2eff1f927471 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -6,4 +6,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin-singleshot.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
> new file mode 100644
> index 000000000000..c3e18fd5bc27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2016 Marvell Technology Group Ltd.
> + *
> + * Device Tree file for MACCHIATOBin Armada 8040 community board platform
> + */
> +
> +#include "armada-8040-mcbin.dtsi"
> +
> +/ {
> +	model = "Marvell 8040 MACCHIATOBin Single-shot";
> +	compatible = "marvell,armada8040-mcbin-singleshot",
> +			"marvell,armada8040-mcbin", "marvell,armada8040",
> +			"marvell,armada-ap806-quad", "marvell,armada-ap806";
> +};
> +
> +&cp0_eth0 {
> +	status = "okay";
> +	phy-mode = "10gbase-kr";
> +	managed = "in-band-status";
> +	sfp = <&sfp_eth0>;
> +};
> +
> +&cp1_eth0 {
> +	status = "okay";
> +	phy-mode = "10gbase-kr";
> +	managed = "in-band-status";
> +	sfp = <&sfp_eth1>;
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index 56fa44860909..d06f5ab7ddab 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -5,226 +5,13 @@
>   * Device Tree file for MACCHIATOBin Armada 8040 community board platform
>   */
>  
> -#include "armada-8040.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> +#include "armada-8040-mcbin.dtsi"
>  
>  / {
> -	model = "Marvell 8040 MACCHIATOBin";
> -	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
> +	model = "Marvell 8040 MACCHIATOBin Double-shot";
> +	compatible = "marvell,armada8040-mcbin-doubleshot",
> +			"marvell,armada8040-mcbin", "marvell,armada8040",
>  			"marvell,armada-ap806-quad", "marvell,armada-ap806";
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x0 0x0 0x0 0x80000000>;
> -	};
> -
> -	aliases {
> -		ethernet0 = &cp0_eth0;
> -		ethernet1 = &cp1_eth0;
> -		ethernet2 = &cp1_eth1;
> -		ethernet3 = &cp1_eth2;
> -	};
> -
> -	/* Regulator labels correspond with schematics */
> -	v_3_3: regulator-3-3v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "v_3_3";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
> -		status = "okay";
> -	};
> -
> -	v_vddo_h: regulator-1-8v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "v_vddo_h";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-always-on;
> -		status = "okay";
> -	};
> -
> -	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cp0_xhci_vbus_pins>;
> -		regulator-name = "v_5v0_usb3_hst_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		status = "okay";
> -	};
> -
> -	usb3h0_phy: usb3_phy0 {
> -		compatible = "usb-nop-xceiv";
> -		vcc-supply = <&v_5v0_usb3_hst_vbus>;
> -	};
> -
> -	sfp_eth0: sfp-eth0 {
> -		/* CON15,16 - CPM lane 4 */
> -		compatible = "sff,sfp";
> -		i2c-bus = <&sfpp0_i2c>;
> -		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
> -		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
> -		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
> -		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cp1_sfpp0_pins>;
> -	};
> -
> -	sfp_eth1: sfp-eth1 {
> -		/* CON17,18 - CPS lane 4 */
> -		compatible = "sff,sfp";
> -		i2c-bus = <&sfpp1_i2c>;
> -		los-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
> -		mod-def0-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
> -		tx-disable-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_HIGH>;
> -		tx-fault-gpio = <&cp0_gpio2 30 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
> -	};
> -
> -	sfp_eth3: sfp-eth3 {
> -		/* CON13,14 - CPS lane 5 */
> -		compatible = "sff,sfp";
> -		i2c-bus = <&sfp_1g_i2c>;
> -		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
> -		mod-def0-gpio = <&cp0_gpio2 21 GPIO_ACTIVE_LOW>;
> -		tx-disable-gpio = <&cp1_gpio1 24 GPIO_ACTIVE_HIGH>;
> -		tx-fault-gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&cp0_sfp_1g_pins &cp1_sfp_1g_pins>;
> -	};
> -};
> -
> -&uart0 {
> -	status = "okay";
> -	pinctrl-0 = <&uart0_pins>;
> -	pinctrl-names = "default";
> -};
> -
> -&ap_sdhci0 {
> -	bus-width = <8>;
> -	/*
> -	 * Not stable in HS modes - phy needs "more calibration", so add
> -	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> -	 */
> -	marvell,xenon-phy-slow-mode;
> -	no-1-8-v;
> -	no-sd;
> -	no-sdio;
> -	non-removable;
> -	status = "okay";
> -	vqmmc-supply = <&v_vddo_h>;
> -};
> -
> -&cp0_i2c0 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_i2c0_pins>;
> -	status = "okay";
> -};
> -
> -&cp0_i2c1 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_i2c1_pins>;
> -	status = "okay";
> -
> -	i2c-switch@70 {
> -		compatible = "nxp,pca9548";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0x70>;
> -
> -		sfpp0_i2c: i2c@0 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0>;
> -		};
> -		sfpp1_i2c: i2c@1 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <1>;
> -		};
> -		sfp_1g_i2c: i2c@2 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <2>;
> -		};
> -	};
> -};
> -
> -/* J25 UART header */
> -&cp0_uart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_uart1_pins>;
> -	status = "okay";
> -};
> -
> -&cp0_mdio {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_ge_mdio_pins>;
> -	status = "okay";
> -
> -	ge_phy: ethernet-phy@0 {
> -		reg = <0>;
> -	};
> -};
> -
> -&cp0_pcie0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_pcie_pins>;
> -	num-lanes = <4>;
> -	num-viewport = <8>;
> -	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
> -	status = "okay";
> -};
> -
> -&cp0_pinctrl {
> -	cp0_ge_mdio_pins: ge-mdio-pins {
> -		marvell,pins = "mpp32", "mpp34";
> -		marvell,function = "ge";
> -	};
> -	cp0_i2c1_pins: i2c1-pins {
> -		marvell,pins = "mpp35", "mpp36";
> -		marvell,function = "i2c1";
> -	};
> -	cp0_i2c0_pins: i2c0-pins {
> -		marvell,pins = "mpp37", "mpp38";
> -		marvell,function = "i2c0";
> -	};
> -	cp0_uart1_pins: uart1-pins {
> -		marvell,pins = "mpp40", "mpp41";
> -		marvell,function = "uart1";
> -	};
> -	cp0_xhci_vbus_pins: xhci0-vbus-pins {
> -		marvell,pins = "mpp47";
> -		marvell,function = "gpio";
> -	};
> -	cp0_sfp_1g_pins: sfp-1g-pins {
> -		marvell,pins = "mpp51", "mpp53", "mpp54";
> -		marvell,function = "gpio";
> -	};
> -	cp0_pcie_pins: pcie-pins {
> -		marvell,pins = "mpp52";
> -		marvell,function = "gpio";
> -	};
> -	cp0_sdhci_pins: sdhci-pins {
> -		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
> -			       "mpp60", "mpp61";
> -		marvell,function = "sdio";
> -	};
> -	cp0_sfpp1_pins: sfpp1-pins {
> -		marvell,pins = "mpp62";
> -		marvell,function = "gpio";
> -	};
>  };
>  
>  &cp0_xmdio {
> @@ -243,46 +30,11 @@
>  	};
>  };
>  
> -&cp0_ethernet {
> -	status = "okay";
> -};
> -
>  &cp0_eth0 {
>  	status = "okay";
>  	/* Network PHY */
>  	phy = <&phy0>;
>  	phy-mode = "10gbase-kr";
> -	/* Generic PHY, providing serdes lanes */
> -	phys = <&cp0_comphy4 0>;
> -};
> -
> -&cp0_sata0 {
> -	/* CPM Lane 0 - U29 */
> -	status = "okay";
> -};
> -
> -&cp0_sdhci0 {
> -	/* U6 */
> -	broken-cd;
> -	bus-width = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp0_sdhci_pins>;
> -	status = "okay";
> -	vqmmc-supply = <&v_3_3>;
> -};
> -
> -&cp0_usb3_0 {
> -	/* J38? - USB2.0 only */
> -	status = "okay";
> -};
> -
> -&cp0_usb3_1 {
> -	/* J38? - USB2.0 only */
> -	status = "okay";
> -};
> -
> -&cp1_ethernet {
> -	status = "okay";
>  };
>  
>  &cp1_eth0 {
> @@ -290,81 +42,4 @@
>  	/* Network PHY */
>  	phy = <&phy8>;
>  	phy-mode = "10gbase-kr";
> -	/* Generic PHY, providing serdes lanes */
> -	phys = <&cp1_comphy4 0>;
> -};
> -
> -&cp1_eth1 {
> -	/* CPS Lane 0 - J5 (Gigabit RJ45) */
> -	status = "okay";
> -	/* Network PHY */
> -	phy = <&ge_phy>;
> -	phy-mode = "sgmii";
> -	/* Generic PHY, providing serdes lanes */
> -	phys = <&cp1_comphy0 1>;
> -};
> -
> -&cp1_eth2 {
> -	/* CPS Lane 5 */
> -	status = "okay";
> -	/* Network PHY */
> -	phy-mode = "2500base-x";
> -	managed = "in-band-status";
> -	/* Generic PHY, providing serdes lanes */
> -	phys = <&cp1_comphy5 2>;
> -	sfp = <&sfp_eth3>;
> -};
> -
> -&cp1_pinctrl {
> -	cp1_sfpp1_pins: sfpp1-pins {
> -		marvell,pins = "mpp8", "mpp10", "mpp11";
> -		marvell,function = "gpio";
> -	};
> -	cp1_spi1_pins: spi1-pins {
> -		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
> -		marvell,function = "spi1";
> -	};
> -	cp1_uart0_pins: uart0-pins {
> -		marvell,pins = "mpp6", "mpp7";
> -		marvell,function = "uart0";
> -	};
> -	cp1_sfp_1g_pins: sfp-1g-pins {
> -		marvell,pins = "mpp24";
> -		marvell,function = "gpio";
> -	};
> -	cp1_sfpp0_pins: sfpp0-pins {
> -		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
> -		marvell,function = "gpio";
> -	};
> -};
> -
> -/* J27 UART header */
> -&cp1_uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp1_uart0_pins>;
> -	status = "okay";
> -};
> -
> -&cp1_sata0 {
> -	/* CPS Lane 1 - U32 */
> -	/* CPS Lane 3 - U31 */
> -	status = "okay";
> -};
> -
> -&cp1_spi1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&cp1_spi1_pins>;
> -	status = "okay";
> -
> -	spi-flash@0 {
> -		compatible = "st,w25q32";
> -		spi-max-frequency = <50000000>;
> -		reg = <0>;
> -	};
> -};
> -
> -&cp1_usb3_0 {
> -	/* CPS Lane 2 - CON7 */
> -	usb-phy = <&usb3h0_phy>;
> -	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> new file mode 100644
> index 000000000000..29ea7e81ec4c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2016 Marvell Technology Group Ltd.
> + *
> + * Device Tree file for MACCHIATOBin Armada 8040 community board platform
> + */
> +
> +#include "armada-8040.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Marvell 8040 MACCHIATOBin";
> +	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
> +			"marvell,armada-ap806-quad", "marvell,armada-ap806";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	aliases {
> +		ethernet0 = &cp0_eth0;
> +		ethernet1 = &cp1_eth0;
> +		ethernet2 = &cp1_eth1;
> +		ethernet3 = &cp1_eth2;
> +	};
> +
> +	/* Regulator labels correspond with schematics */
> +	v_3_3: regulator-3-3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v_3_3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		status = "okay";
> +	};
> +
> +	v_vddo_h: regulator-1-8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v_vddo_h";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		status = "okay";
> +	};
> +
> +	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp0_xhci_vbus_pins>;
> +		regulator-name = "v_5v0_usb3_hst_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		status = "okay";
> +	};
> +
> +	usb3h0_phy: usb3_phy0 {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&v_5v0_usb3_hst_vbus>;
> +	};
> +
> +	sfp_eth0: sfp-eth0 {
> +		/* CON15,16 - CPM lane 4 */
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfpp0_i2c>;
> +		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp1_sfpp0_pins>;
> +	};
> +
> +	sfp_eth1: sfp-eth1 {
> +		/* CON17,18 - CPS lane 4 */
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfpp1_i2c>;
> +		los-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&cp0_gpio2 30 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
> +	};
> +
> +	sfp_eth3: sfp-eth3 {
> +		/* CON13,14 - CPS lane 5 */
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfp_1g_i2c>;
> +		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&cp0_gpio2 21 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&cp1_gpio1 24 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp0_sfp_1g_pins &cp1_sfp_1g_pins>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&ap_sdhci0 {
> +	bus-width = <8>;
> +	/*
> +	 * Not stable in HS modes - phy needs "more calibration", so add
> +	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> +	 */
> +	marvell,xenon-phy-slow-mode;
> +	no-1-8-v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	status = "okay";
> +	vqmmc-supply = <&v_vddo_h>;
> +};
> +
> +&cp0_i2c0 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_i2c0_pins>;
> +	status = "okay";
> +};
> +
> +&cp0_i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_i2c1_pins>;
> +	status = "okay";
> +
> +	i2c-switch@70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +
> +		sfpp0_i2c: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		sfpp1_i2c: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		sfp_1g_i2c: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +	};
> +};
> +
> +/* J25 UART header */
> +&cp0_uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_uart1_pins>;
> +	status = "okay";
> +};
> +
> +&cp0_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_ge_mdio_pins>;
> +	status = "okay";
> +
> +	ge_phy: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&cp0_pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_pcie_pins>;
> +	num-lanes = <4>;
> +	num-viewport = <8>;
> +	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&cp0_pinctrl {
> +	cp0_ge_mdio_pins: ge-mdio-pins {
> +		marvell,pins = "mpp32", "mpp34";
> +		marvell,function = "ge";
> +	};
> +	cp0_i2c1_pins: i2c1-pins {
> +		marvell,pins = "mpp35", "mpp36";
> +		marvell,function = "i2c1";
> +	};
> +	cp0_i2c0_pins: i2c0-pins {
> +		marvell,pins = "mpp37", "mpp38";
> +		marvell,function = "i2c0";
> +	};
> +	cp0_uart1_pins: uart1-pins {
> +		marvell,pins = "mpp40", "mpp41";
> +		marvell,function = "uart1";
> +	};
> +	cp0_xhci_vbus_pins: xhci0-vbus-pins {
> +		marvell,pins = "mpp47";
> +		marvell,function = "gpio";
> +	};
> +	cp0_sfp_1g_pins: sfp-1g-pins {
> +		marvell,pins = "mpp51", "mpp53", "mpp54";
> +		marvell,function = "gpio";
> +	};
> +	cp0_pcie_pins: pcie-pins {
> +		marvell,pins = "mpp52";
> +		marvell,function = "gpio";
> +	};
> +	cp0_sdhci_pins: sdhci-pins {
> +		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
> +			       "mpp60", "mpp61";
> +		marvell,function = "sdio";
> +	};
> +	cp0_sfpp1_pins: sfpp1-pins {
> +		marvell,pins = "mpp62";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&cp0_ethernet {
> +	status = "okay";
> +};
> +
> +&cp0_eth0 {
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&cp0_comphy4 0>;
> +};
> +
> +&cp0_sata0 {
> +	/* CPM Lane 0 - U29 */
> +	status = "okay";
> +};
> +
> +&cp0_sdhci0 {
> +	/* U6 */
> +	broken-cd;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_sdhci_pins>;
> +	status = "okay";
> +	vqmmc-supply = <&v_3_3>;
> +};
> +
> +&cp0_usb3_0 {
> +	/* J38? - USB2.0 only */
> +	status = "okay";
> +};
> +
> +&cp0_usb3_1 {
> +	/* J38? - USB2.0 only */
> +	status = "okay";
> +};
> +
> +&cp1_ethernet {
> +	status = "okay";
> +};
> +
> +&cp1_eth0 {
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&cp1_comphy4 0>;
> +};
> +
> +&cp1_eth1 {
> +	/* CPS Lane 0 - J5 (Gigabit RJ45) */
> +	status = "okay";
> +	/* Network PHY */
> +	phy = <&ge_phy>;
> +	phy-mode = "sgmii";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&cp1_comphy0 1>;
> +};
> +
> +&cp1_eth2 {
> +	/* CPS Lane 5 */
> +	status = "okay";
> +	/* Network PHY */
> +	phy-mode = "2500base-x";
> +	managed = "in-band-status";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&cp1_comphy5 2>;
> +	sfp = <&sfp_eth3>;
> +};
> +
> +&cp1_pinctrl {
> +	cp1_sfpp1_pins: sfpp1-pins {
> +		marvell,pins = "mpp8", "mpp10", "mpp11";
> +		marvell,function = "gpio";
> +	};
> +	cp1_spi1_pins: spi1-pins {
> +		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
> +		marvell,function = "spi1";
> +	};
> +	cp1_uart0_pins: uart0-pins {
> +		marvell,pins = "mpp6", "mpp7";
> +		marvell,function = "uart0";
> +	};
> +	cp1_sfp_1g_pins: sfp-1g-pins {
> +		marvell,pins = "mpp24";
> +		marvell,function = "gpio";
> +	};
> +	cp1_sfpp0_pins: sfpp0-pins {
> +		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +/* J27 UART header */
> +&cp1_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp1_uart0_pins>;
> +	status = "okay";
> +};
> +
> +&cp1_sata0 {
> +	/* CPS Lane 1 - U32 */
> +	/* CPS Lane 3 - U31 */
> +	status = "okay";
> +};
> +
> +&cp1_spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp1_spi1_pins>;
> +	status = "okay";
> +
> +	spi-flash@0 {
> +		compatible = "st,w25q32";
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&cp1_usb3_0 {
> +	/* CPS Lane 2 - CON7 */
> +	usb-phy = <&usb3h0_phy>;
> +	status = "okay";
> +};
> -- 
> 2.7.4
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
