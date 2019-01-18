Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:46:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A992087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WMOHPeIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A992087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZ1TjaxgUvQko+Jm5AS9OZdzcywSLzWuGXrFCZNJsjw=; b=WMOHPeIKp5xYnp
	+ANNvLKNmARL1tK596UKWwQ/ZVQuNnZ0D5FvG0y1p0jRcs6L70m0JDK9EEeFdiAxbOZLTUlntMNVC
	YvUJsiEqJ4CSUWsI5dZlzyJhnCc/Ft4z7InPH08iRgQpdaPp2TisYxARiEfuUGrw6J+5MVGJVeGzn
	r2r6Gryunmxm7JXtSKnbaG8wyYpwoCTrPh2F05qpomjBrYlbu+Lk+j9uxd7ozMP9UYPgmZ9HcUkKI
	nMNRQnUNJapAcDYhNagQxbliQfAN2Veu8LeiM0PUJICAyxxRuCMFYOKFLBt81FtNwAN2MHsIFiwpS
	gKdVB11KPDKfZSdNZI4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWLH-0005Tq-Qa; Fri, 18 Jan 2019 15:45:59 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWLE-0005K0-EZ
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:45:58 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 03519209C0; Fri, 18 Jan 2019 16:45:50 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id E978020908;
 Fri, 18 Jan 2019 16:45:38 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH v4] arm64: dts: marvell: Add device tree for uDPU board
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
 <20190115173842.30367-1-vladimir.vid@sartura.hr>
Date: Fri, 18 Jan 2019 16:45:36 +0100
In-Reply-To: <20190115173842.30367-1-vladimir.vid@sartura.hr> (Vladimir Vid's
 message of "Tue, 15 Jan 2019 18:38:43 +0100")
Message-ID: <87d0oum0kf.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_074556_823594_DE3D0CA1 
X-CRM114-Status: GOOD (  25.15  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Jason Cooper <jason@lakedaemon.net>, Paul Arola <paul.arola@telus.com>,
 Andrew Lunn <andrew@lunn.ch>, Scott Roberts <scott.roberts@telus.com>,
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vladimir,
 
 On mar., janv. 15 2019, Vladimir Vid <vladimir.vid@sartura.hr> wrote:

> This adds initial support for micro-DPU (uDPU) board which is based on
> Armada-3720 SoC.  micro-DPU is the single-port FTTdp distribution point
> unit made by Methode Electronics which offers complete modularity with
> replaceable SFP modules both for uplink and downlink (G.hn over
> twisted-pair, G.hn over coax, 1G and 2.5G Ethernet over Cat-5e cable).
>
> On-board features:
> - 512 MiB DDR3
> - 2 x 2.5G SFP via HSGMII SERDES interface to the A3720 SoC
> - USB 2.0 Type-C connector
> - 4GB eMMC
> - ETSI TS 101548 reverse powering via twisted pair (RJ45) or coax (F Type)
>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Luis Torres <luis.torres@methode.com>
> Cc: Scott Roberts <scott.roberts@telus.com>
> Cc: Paul Arola <paul.arola@telus.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
> ---
>
> v2:
> - add compatible string for the uDPU board
> - add names and labels for the LEDs
> - remove unused mdio node
> - remove eeprom nodes
>
> v3:
> - update copyright year for Methode and Telus
> - fix Methode copyright (use Methode Electornics instead of Methode)
> - sort compatible string by relevance, remove armada-3720-db and
> armada3710 to keep it generic
>
> v4:
> - add generic names for LEDs since they don't use regs
> - add 'partitions' section to standarize with other A37xx/A7K/A8K dts's
> - remove usb3 phandle because of the broken usb_phy (previously used on
> Marvell linux repo) and since usb support is still work in progress
>
> ---
>  MAINTAINERS                                   |   5 +
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 163 ++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..4ba06bfc1a1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9852,6 +9852,11 @@ F:	drivers/media/platform/meson/ao-cec.c
>  F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
>  T:	git git://linuxtv.org/media_tree.git
>  
> +METHODE UDPU SUPPORT
> +M:	Vladimir Vid <vladimir.vid@sartura.hr>
> +S:	Maintained
> +F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +
>  MICROBLAZE ARCHITECTURE
>  M:	Michal Simek <monstr@monstr.eu>
>  W:	http://www.monstr.eu/fdt/
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 2eff1f927471..caed4334f27d 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -2,6 +2,7 @@
>  # Mvebu SoC Family
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> new file mode 100644
> index 000000000000..1d7e6c82d3ec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device tree for the uDPU board.
> + * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
> + * Copyright (C) 2016 Marvell
> + * Copyright (C) 2019 Methode Electronics
> + * Copyright (C) 2019 Telus
> + *
> + * Vladimir Vid <vladimir.vid@sartura.hr>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "Methode uDPU Board";
> +	compatible = "methode,udpu", "marvell,armada3720";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
> +	leds {
> +		pinctrl-names = "default";
> +		compatible = "gpio-leds";
> +
> +		power1 {
> +			label = "power:green:led1";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		power2 {
> +			label = "power:red:led1";
> +			gpios = <&gpionb 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		network1 {
> +			label = "network:green:led2";
> +			gpios = <&gpionb 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		network2 {
> +			label = "network:red:led2";
> +			gpios = <&gpionb 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		alarm1 {
> +			label = "alarm:green:led3";
> +			gpios = <&gpionb 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		alarm2 {
> +			label = "alarm:red:led3";
> +			gpios = <&gpionb 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	sfp_eth0: sfp-eth0 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c0>;
> +		los-gpio = <&gpiosb 2 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&gpiosb 3 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&gpiosb 4 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	sfp_eth1: sfp-eth1 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&sdhci0 {
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,pad-type = "fixed-1-8v";
> +	status = "okay";
> +};
> +
> +&sdhci1 {
> +	marvell,xenon-phy-type = "emmc 5.0 phy";

You have a GPIO for a card detect here:
> +	cd-gpios = <&gpiosb 2 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	marvell,pad-type = "fixed-1-8v";
> +	status = "okay";

But here you say that the card is not removable:
> +	non-removable;
> +	no-sd;
> +	no-sdio;

Can you explain what do you expect to be connected here?

Thanks,

Gregory


> +};
> +
> +&spi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_quad_pins>;
> +
> +	m25p80@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <54000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* only bootloader is located on the SPI */
> +			partition@0 {
> +				label = "uboot";
> +				reg = <0 0x400000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +};
> +
> +&eth0 {
> +	phy-mode = "sgmii";
> +	status = "okay";
> +	managed = "in-band-status";
> +	sfp = <&sfp_eth0>;
> +};
> +
> +&eth1 {
> +	phy-mode = "sgmii";
> +	status = "okay";
> +	managed = "in-band-status";
> +	sfp = <&sfp_eth1>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 2.19.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
