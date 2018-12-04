Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4FD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gqh81Dk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4FD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/eCVqm22R/mJzrX1GdRJDH1c8vZOe6/eaqYKMlWREN0=; b=Gqh81Dk6iK6h0c
	zUkNh51gm+DE4gpyBs1mAqvWhXleUFmPtWEDdSs0kgjQMlokGlagtA2UcLd42W91sd+5z9yaTsEUu
	tNBzb56mSty8mFCI0b0OUEFJlvbFGOZnYWmJ+YLI5rkm5Xrro90dhNBy7mM46SgExSqttDUZRtBFc
	5z3ns2Lf6FcAMj7R4cWpdQYviFh+j9eqtJgl37GwCBT4kNWZUsVIrpqUUJGWDFl2/XcvHeBPcw+gD
	x0xZa7I0drRW//Ch6hPpTjyZu79BOA/o41kHzjUKTSUjaYA2JdabUszUx8nSm1MQd0vdTCjvlK0gV
	hYw5LJYNbGXB6GWIohLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHRb-0006FI-Qu; Tue, 04 Dec 2018 20:37:23 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHRX-0006EP-Ek
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:37:22 +0000
Received: by mail-ot1-f67.google.com with SMTP id f18so16470276otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=UTSRfr0tz3UPq+Yw8V1rqUYSeCv0zgMpLTw2+JfbXXQ=;
 b=iCnY/IySrWitr4HQHQjMGqg7UnlfCkElkMQcEx370Kr81ardoLZ5XpQIO21bU0wigW
 adrO6jKQWbjq2iqxSNJn0g1Hg+64H6KbynuXeU5LxcJrmo6mnS93KTVfScSnHzYHNQ8Q
 xDdHpEh9cr7HRVF94+ecTiKrS70FO6AZgiz/jdES3SodKQjJrT6p9qRQbrEOIFHtufzB
 I1nx3L4O3GuwMsYtVuG4p4wUu82xqHbmGEP7s4vNN+UPj7oSJygrX6bPTFUyckTJtdDj
 eTBPnjRxmaQQX/oMyIYmjMinkeaAKHDJ4wIKWyGPNTt16evMEtHMf/VLEPiSpphFH7cQ
 Er+w==
X-Gm-Message-State: AA+aEWZqdvnmJiGBJFuoYQb3ilJaoFhxhZ6LcwViNWjW+FB5nEXKFkio
 ZBejlM861+fuZMEzHd8buw==
X-Google-Smtp-Source: AFSGD/V2F7IZtraYahdBSuMybubjTa1SFvHzlnZ/4pX29V5wytntdQx+Dmi1uFkf1P23/bfrmbxpMA==
X-Received: by 2002:a9d:401:: with SMTP id 1mr13250381otc.78.1543955828329;
 Tue, 04 Dec 2018 12:37:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j33sm14472400ota.32.2018.12.04.12.37.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 12:37:07 -0800 (PST)
Date: Tue, 4 Dec 2018 14:37:06 -0600
From: Rob Herring <robh@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Subject: Re: [PATCH RFC] ARM64: dts: marvell: Add DTS file for Turris Mox
Message-ID: <20181204203706.GA25038@bogus>
References: <20181113134408.5681-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181113134408.5681-1-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123719_500383_13E793BA 
X-CRM114-Status: GOOD (  30.98  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 13, 2018 at 02:44:08PM +0100, Marek Beh=FAn wrote:
> This is a RFC, please do not merge.
> =

> This adds basic support for the Turris Mox board from CZ.NIC.
> =

> Turris Mox is as modular router based on the Armada 3720 SOC (same as
> EspressoBin).
> =

> The basic module can be extended by different modules.
> When those modules are connected, U-Boot has to let kernel know via
> device-tree. Since modules can be connected in different order and
> some modules can be connected multiple times (up to three 8-port
> switch modules can be connected), using dtb overlays would result in
> too files.
> =

> I therefore chose to put all the possible connected devices in one dts
> and disable them. If U-Boot finds these modules, it fixes the device
> tree accrodginly, by enabling some nodes (setting status to "okay") and
> by setting some addresses and references.

Given it is a whole hierarchy of nodes, might be cleaner if u-boot =

removes the whole sub-tree of disable nodes.

> For example there are 6 switch nodes - three for 8-port switch module
> and three for 4-port switch module. This is because another switch
> (either 8-port or 4-port) can be connected to a 8-port switch, in DSA,
> and interface names have to be defined (from lan1 to lan24).
> =

> Another way (for defining switch nodes) would have to be either:
>   - including a file where switch nodes are defined, which would need
>     #defining lan interface names (and some other things), and #undefing
>     them after the #include
>   - defining a macro for switch nodes
>   - have a separate DTBs for each possible configuration (this would
>     result in too many DTBs)
>   - not defining these nodes in device-tree at all, instead creating
>     them in U-Boot when patching the device-tree (I actually tried this,
>     but the resulting code in U-Boot was horrible)
> =

> Please let me know if doing it this way is acceptable, or if I should
> try something different (and if yes, what?).
> =

> Signed-off-by: Marek Beh=FAn <marek.behun@nic.cz>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../arm/marvell/armada-3720-turris-mox.txt    |   6 +
>  MAINTAINERS                                   |   1 +
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../dts/marvell/armada-3720-turris-mox.dts    | 838 ++++++++++++++++++
>  4 files changed, 846 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
3720-turris-mox.txt
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> =

> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-3720-tu=
rris-mox.txt b/Documentation/devicetree/bindings/arm/marvell/armada-3720-tu=
rris-mox.txt
> new file mode 100644
> index 000000000000..408fc07a9bbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mo=
x.txt
> @@ -0,0 +1,6 @@
> +CZ.NIC's Turris Mox SOHO router Device Tree Bindings
> +----------------------------------------------------
> +
> +Required root node property:
> +
> +compatible: must contain "cznic,turris-mox"

This should also contain the SoC compatible. Please add this to where =

that is defined instead of a new file.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6e60e7f6c11..81b57260b110 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1348,6 +1348,7 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
>  M:	Marek Behun <marek.behun@nic.cz>
>  W:	http://mox.turris.cz
>  S:	Maintained
> +F:	arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>  F:	include/mfd/moxtet.h
>  F:	drivers/gpio/gpio-moxtet.c
>  F:	drivers/mfd/moxtet.c
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/m=
arvell/Makefile
> index 5633676fa9d0..51782b31b441 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_BERLIN) +=3D berlin4ct-stb.dtb
>  # Mvebu SoC Family
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-turris-mox.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-7040-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-8040-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-8040-mcbin.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> new file mode 100644
> index 000000000000..1315c59ecef3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -0,0 +1,838 @@
> +// SPDX-License-Identifier: GPL-2.0+ or X11
> +/*
> + * Device Tree file for CZ.NIC Turris Mox Board
> + * 2018 by Marek Behun <marek.behun@nic.cz>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model =3D "CZ.NIC Turris Mox Board";
> +	compatible =3D "cznic,turris-mox", "marvell,armada3720",
> +		     "marvell,armada3710";
> +
> +	aliases {
> +		spi0 =3D &spi0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		red {
> +			gpios =3D <&gpiosb 21 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible =3D "gpio-keys";
> +
> +		reset_button {

reset {

Don't use '_' in node names. Building with W=3D2 will tell you this. You =

chould build with W=3D1 and fix any warnings this file adds.

> +			label =3D "reset";
> +			linux,code =3D <BTN_MISC>;
> +			gpios =3D <&gpiosb 20 GPIO_ACTIVE_LOW>;
> +			debounce-interval =3D <60>;
> +		};
> +	};
> +
> +	exp_usb3_vbus: usb3-vbus {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "usb3-vbus";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		gpio =3D <&gpiosb 0 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	usb3_phy: usb3-phy {
> +		compatible =3D "usb-nop-xceiv";
> +		vcc-supply =3D <&exp_usb3_vbus>;
> +	};
> +
> +	vsdc_reg: vsdc_reg {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "vsdc";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +
> +		gpios =3D <&gpiosb 23 GPIO_ACTIVE_HIGH>;
> +		gpios-states =3D <0>;
> +		states =3D <1800000 0x1
> +			  3300000 0x0>;
> +		enable-active-high;
> +	};
> +
> +	vsdio_reg: vsdio_reg {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "vsdio";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +
> +		gpios =3D <&gpiosb 22 GPIO_ACTIVE_HIGH>;
> +		gpios-states =3D <0>;
> +		states =3D <1800000 0x1
> +			  3300000 0x0>;
> +		enable-active-high;
> +	};
> +
> +	sdhci1_pwrseq: sdhci1_pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&gpionb 19 GPIO_ACTIVE_HIGH>;
> +		status =3D "okay";
> +	};
> +
> +	sfp: sfp {
> +		compatible =3D "sff,sfp+";
> +		i2c-bus =3D <&i2c0>;
> +		los-gpio =3D <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio =3D <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio =3D <&moxtet_sfp 2 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio =3D <&moxtet_sfp 3 GPIO_ACTIVE_HIGH>;
> +		rate-select0-gpio =3D <&moxtet_sfp 4 GPIO_ACTIVE_HIGH>;
> +		status =3D "disabled";
> +	};
> +};
> +
> +&pinctrl_nb {
> +	spi_cs1_pins: spi-cs1-pins {
> +		groups =3D "spi_cs1";
> +		function =3D "spi";
> +	};
> +
> +	sdio0_pins: sdio0-pins {
> +		groups =3D "sdio0";
> +		function =3D "sdio";
> +	};
> +};
> +
> +&pinctrl_sb {
> +	sdio_sb_pins: sdio-sb-pins {
> +		groups =3D "sdio_sb";
> +		function =3D "sdio";
> +	};
> +
> +	smi_pins: smi-pins {
> +		groups =3D "smi";
> +		function =3D "smi";
> +	};
> +
> +	pcie_pins: pcie1-pins {
> +		groups =3D "pcie1";
> +		function =3D "gpio";
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pins>;
> +	status =3D "okay";
> +
> +	rtc@6f {
> +		compatible =3D "microchip,mcp7940x";
> +		reg =3D <0x6f>;
> +	};
> +};
> +
> +&pcie0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie_pins>;
> +	status =3D "okay";
> +	max-link-speed =3D <2>;
> +	reset-gpio =3D <&gpiosb 3 GPIO_ACTIVE_HIGH>;

reset-gpios is the preferred form.

> +
> +	/* this shall be enabled by u-boot if the PCIe module is present */
> +	status =3D "disabled";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&eth0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&rgmii_pins>;
> +	phy-mode =3D "rgmii-id";
> +	phy =3D <&phy1>;
> +	status =3D "okay";
> +};
> +
> +&eth1 {
> +	phy-mode =3D "1000base-x";
> +	managed =3D "in-band-status";
> +};
> +
> +&mdio {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&smi_pins>;
> +	status =3D "okay";
> +
> +	phy1: ethernet-phy@1 {
> +		reg =3D <1>;
> +	};
> +
> +	switch0@10 {
> +		compatible =3D "marvell,mv88e6190";
> +		reg =3D <0x10 0>;
> +		dsa,member =3D <0 0>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch0phy1: switch0phy1@1 {
> +				reg =3D <0x1>;
> +			};
> +
> +			switch0phy2: switch0phy2@2 {
> +				reg =3D <0x2>;
> +			};
> +
> +			switch0phy3: switch0phy3@3 {
> +				reg =3D <0x3>;
> +			};
> +
> +			switch0phy4: switch0phy4@4 {
> +				reg =3D <0x4>;
> +			};
> +
> +			switch0phy5: switch0phy5@5 {
> +				reg =3D <0x5>;
> +			};
> +
> +			switch0phy6: switch0phy6@6 {
> +				reg =3D <0x6>;
> +			};
> +
> +			switch0phy7: switch0phy7@7 {
> +				reg =3D <0x7>;
> +			};
> +
> +			switch0phy8: switch0phy8@8 {
> +				reg =3D <0x8>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan1";
> +				phy-handle =3D <&switch0phy1>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan2";
> +				phy-handle =3D <&switch0phy2>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan3";
> +				phy-handle =3D <&switch0phy3>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan4";
> +				phy-handle =3D <&switch0phy4>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "lan5";
> +				phy-handle =3D <&switch0phy5>;
> +			};
> +
> +			port@6 {
> +				reg =3D <0x6>;
> +				label =3D "lan6";
> +				phy-handle =3D <&switch0phy6>;
> +			};
> +
> +			port@7 {
> +				reg =3D <0x7>;
> +				label =3D "lan7";
> +				phy-handle =3D <&switch0phy7>;
> +			};
> +
> +			port@8 {
> +				reg =3D <0x8>;
> +				label =3D "lan8";
> +				phy-handle =3D <&switch0phy8>;
> +			};
> +
> +			port@9 {
> +				reg =3D <0x9>;
> +				label =3D "cpu";
> +				ethernet =3D <&eth1>;
> +			};
> +
> +			switch0port10: port@a {
> +				reg =3D <0xa>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch1port9 &switch2port9>;
> +				status =3D "disabled";
> +			};
> +
> +			port-sfp@a {
> +				reg =3D <0xa>;
> +				label =3D "sfp";
> +				sfp =3D <&sfp>;
> +				phy-mode =3D "sgmii";
> +				managed =3D "in-band-status";
> +				status =3D "disabled";
> +			};
> +		};
> +	};
> +
> +	switch0@2 {
> +		compatible =3D "marvell,mv88e6085";
> +		reg =3D <0x2 0>;
> +		dsa,member =3D <0 0>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch0phy1_topaz: switch0phy1@11 {
> +				reg =3D <0x11>;
> +			};
> +
> +			switch0phy2_topaz: switch0phy2@12 {
> +				reg =3D <0x12>;
> +			};
> +
> +			switch0phy3_topaz: switch0phy3@13 {
> +				reg =3D <0x13>;
> +			};
> +
> +			switch0phy4_topaz: switch0phy4@14 {
> +				reg =3D <0x14>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan1";
> +				phy-handle =3D <&switch0phy1_topaz>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan2";
> +				phy-handle =3D <&switch0phy2_topaz>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan3";
> +				phy-handle =3D <&switch0phy3_topaz>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan4";
> +				phy-handle =3D <&switch0phy4_topaz>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "cpu";
> +				ethernet =3D <&eth1>;
> +			};
> +		};
> +	};
> +
> +	switch1@11 {
> +		compatible =3D "marvell,mv88e6190";
> +		reg =3D <0x11 0>;
> +		dsa,member =3D <0 1>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch1phy1: switch1phy1@1 {
> +				reg =3D <0x1>;
> +			};
> +
> +			switch1phy2: switch1phy2@2 {
> +				reg =3D <0x2>;
> +			};
> +
> +			switch1phy3: switch1phy3@3 {
> +				reg =3D <0x3>;
> +			};
> +
> +			switch1phy4: switch1phy4@4 {
> +				reg =3D <0x4>;
> +			};
> +
> +			switch1phy5: switch1phy5@5 {
> +				reg =3D <0x5>;
> +			};
> +
> +			switch1phy6: switch1phy6@6 {
> +				reg =3D <0x6>;
> +			};
> +
> +			switch1phy7: switch1phy7@7 {
> +				reg =3D <0x7>;
> +			};
> +
> +			switch1phy8: switch1phy8@8 {
> +				reg =3D <0x8>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan9";
> +				phy-handle =3D <&switch1phy1>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan10";
> +				phy-handle =3D <&switch1phy2>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan11";
> +				phy-handle =3D <&switch1phy3>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan12";
> +				phy-handle =3D <&switch1phy4>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "lan13";
> +				phy-handle =3D <&switch1phy5>;
> +			};
> +
> +			port@6 {
> +				reg =3D <0x6>;
> +				label =3D "lan14";
> +				phy-handle =3D <&switch1phy6>;
> +			};
> +
> +			port@7 {
> +				reg =3D <0x7>;
> +				label =3D "lan15";
> +				phy-handle =3D <&switch1phy7>;
> +			};
> +
> +			port@8 {
> +				reg =3D <0x8>;
> +				label =3D "lan16";
> +				phy-handle =3D <&switch1phy8>;
> +			};
> +
> +			switch1port9: port@9 {
> +				reg =3D <0x9>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch0port10>;
> +			};
> +
> +			switch1port10: port@a {
> +				reg =3D <0xa>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch2port9>;
> +				status =3D "disabled";
> +			};
> +
> +			port-sfp@a {
> +				reg =3D <0xa>;
> +				label =3D "sfp";
> +				sfp =3D <&sfp>;
> +				phy-mode =3D "sgmii";
> +				managed =3D "in-band-status";
> +				status =3D "disabled";
> +			};
> +		};
> +	};
> +
> +	switch1@2 {

Ideally, we shouldn't have this switch0, switch1, etc.

> +		compatible =3D "marvell,mv88e6085";
> +		reg =3D <0x2 0>;
> +		dsa,member =3D <0 1>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch1phy1_topaz: switch1phy1@11 {
> +				reg =3D <0x11>;
> +			};
> +
> +			switch1phy2_topaz: switch1phy2@12 {
> +				reg =3D <0x12>;
> +			};
> +
> +			switch1phy3_topaz: switch1phy3@13 {
> +				reg =3D <0x13>;
> +			};
> +
> +			switch1phy4_topaz: switch1phy4@14 {
> +				reg =3D <0x14>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan9";
> +				phy-handle =3D <&switch1phy1_topaz>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan10";
> +				phy-handle =3D <&switch1phy2_topaz>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan11";
> +				phy-handle =3D <&switch1phy3_topaz>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan12";
> +				phy-handle =3D <&switch1phy4_topaz>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch0port10>;
> +			};
> +		};
> +	};
> +
> +	switch2@12 {
> +		compatible =3D "marvell,mv88e6190";
> +		reg =3D <0x12 0>;
> +		dsa,member =3D <0 2>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch2phy1: switch2phy1@1 {
> +				reg =3D <0x1>;
> +			};
> +
> +			switch2phy2: switch2phy2@2 {
> +				reg =3D <0x2>;
> +			};
> +
> +			switch2phy3: switch2phy3@3 {
> +				reg =3D <0x3>;
> +			};
> +
> +			switch2phy4: switch2phy4@4 {
> +				reg =3D <0x4>;
> +			};
> +
> +			switch2phy5: switch2phy5@5 {
> +				reg =3D <0x5>;
> +			};
> +
> +			switch2phy6: switch2phy6@6 {
> +				reg =3D <0x6>;
> +			};
> +
> +			switch2phy7: switch2phy7@7 {
> +				reg =3D <0x7>;
> +			};
> +
> +			switch2phy8: switch2phy8@8 {
> +				reg =3D <0x8>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan17";
> +				phy-handle =3D <&switch2phy1>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan18";
> +				phy-handle =3D <&switch2phy2>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan19";
> +				phy-handle =3D <&switch2phy3>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan20";
> +				phy-handle =3D <&switch2phy4>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "lan21";
> +				phy-handle =3D <&switch2phy5>;
> +			};
> +
> +			port@6 {
> +				reg =3D <0x6>;
> +				label =3D "lan22";
> +				phy-handle =3D <&switch2phy6>;
> +			};
> +
> +			port@7 {
> +				reg =3D <0x7>;
> +				label =3D "lan23";
> +				phy-handle =3D <&switch2phy7>;
> +			};
> +
> +			port@8 {
> +				reg =3D <0x8>;
> +				label =3D "lan24";
> +				phy-handle =3D <&switch2phy8>;
> +			};
> +
> +			switch2port9: port@9 {
> +				reg =3D <0x9>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch1port10 &switch0port10>;
> +			};
> +
> +			port-sfp@a {
> +				reg =3D <0xa>;
> +				label =3D "sfp";
> +				sfp =3D <&sfp>;
> +				phy-mode =3D "sgmii";
> +				managed =3D "in-band-status";
> +				status =3D "disabled";
> +			};
> +		};
> +	};
> +
> +	switch2@2 {
> +		compatible =3D "marvell,mv88e6085";
> +		reg =3D <0x2 0>;
> +		dsa,member =3D <0 2>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +		status =3D "disabled";
> +
> +		mdio {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			switch2phy1_topaz: switch2phy1@11 {
> +				reg =3D <0x11>;
> +			};
> +
> +			switch2phy2_topaz: switch2phy2@12 {
> +				reg =3D <0x12>;
> +			};
> +
> +			switch2phy3_topaz: switch2phy3@13 {
> +				reg =3D <0x13>;
> +			};
> +
> +			switch2phy4_topaz: switch2phy4@14 {
> +				reg =3D <0x14>;
> +			};
> +		};
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@1 {
> +				reg =3D <0x1>;
> +				label =3D "lan17";
> +				phy-handle =3D <&switch2phy1_topaz>;
> +			};
> +
> +			port@2 {
> +				reg =3D <0x2>;
> +				label =3D "lan18";
> +				phy-handle =3D <&switch2phy2_topaz>;
> +			};
> +
> +			port@3 {
> +				reg =3D <0x3>;
> +				label =3D "lan19";
> +				phy-handle =3D <&switch2phy3_topaz>;
> +			};
> +
> +			port@4 {
> +				reg =3D <0x4>;
> +				label =3D "lan20";
> +				phy-handle =3D <&switch2phy4_topaz>;
> +			};
> +
> +			port@5 {
> +				reg =3D <0x5>;
> +				label =3D "dsa";
> +				phy-mode =3D "2500base-x";
> +				link =3D <&switch1port10 &switch0port10>;
> +			};
> +		};
> +	};
> +
> +};
> +
> +&sdhci0 {
> +	wp-inverted;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&gpionb 10 GPIO_ACTIVE_HIGH>;
> +	vqmmc-supply =3D <&vsdc_reg>;
> +	marvell,pad-type =3D "sd";
> +	status =3D "okay";
> +};
> +
> +&sdhci1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&sdio0_pins &sdio_sb_pins>;
> +	non-removable;
> +	bus-width =3D <4>;
> +	marvell,pad-type =3D "sd";
> +	vqmmc-supply =3D <&vsdio_reg>;
> +	mmc-pwrseq =3D <&sdhci1_pwrseq>;
> +	status =3D "okay";
> +};
> +
> +&spi0 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi_quad_pins &spi_cs1_pins>;
> +	assigned-clocks =3D <&nb_periph_clk 7>;
> +	assigned-clock-parents =3D <&tbg 1>;
> +	assigned-clock-rates =3D <20000000>;
> +
> +	spi-flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <20000000>;
> +
> +		partition@0 {

All these under a 'partitions' node is preferred.

> +			label =3D "secure-firmware";
> +			reg =3D <0x0 0x20000>;
> +		};
> +
> +		partition@20000 {
> +			label =3D "u-boot";
> +			reg =3D <0x20000 0x160000>;
> +		};
> +
> +		partition@180000 {
> +			label =3D "u-boot-env";
> +			reg =3D <0x180000 0x10000>;
> +		};
> +
> +		partition@190000 {
> +			label =3D "Rescue system";
> +			reg =3D <0x190000 0x660000>;
> +		};
> +
> +		partition@7f0000 {
> +			label =3D "dtb";
> +			reg =3D <0x7f0000 0x10000>;
> +		};
> +	};
> +
> +	moxtet@1 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		compatible =3D "cznic,moxtet";

All this node needs to be documented.

> +		reg =3D <1>;
> +		devrst-gpio =3D <&gpiosb 2 GPIO_ACTIVE_LOW>;

Not documented. reset-gpios is preferred for GPIO reset lines.

> +		spi-max-frequency =3D <10000000>;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		moxtet_sfp: moxtet-sfp@0 {
> +			compatible =3D "cznic,moxtet-gpio";
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			reg =3D <0>;
> +			moxtet,id =3D <1>;
> +			moxtet,input-mask =3D <0x7>;
> +			moxtet,output-mask =3D <0x3>;
> +			status =3D "disabled";
> +		};
> +	};
> +};
> +
> +&usb2 {
> +	status =3D "okay";
> +};
> +
> +&usb3 {
> +	status =3D "okay";
> +	usb-phy =3D <&usb3_phy>;
> +};
> -- =

> 2.18.1
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
