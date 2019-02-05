Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32E7217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CLRvGhq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32E7217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PgFdGPlWlBsc9gpPQ4PJsvvjffOZ7eaz5WL2YZggWAw=; b=CLRvGhq8PrlBOl
	IGpoDgk5w1KBAw3MSiQquCpqeupJenrrbC6g88Md3KdcMU7BbFRHG98k2Nc/r6bLjmxugzSrI7GxN
	ngUjce7zB+ieE1uLQDrDX7NmaIluvFVBs6KbV+PJ17JKhAWRocXANqGbaPnTCe3iCgVuNkRUvyld8
	aVnkX/CtEZIa3/AoYlk+2xgfpDdaWxetNnr+FaQa+b9aHmRRNnL2pH0ROq8YGneBqZylOgECmEhnD
	n8+7mf1iOyBI3s3bVbkI6rI9VDI1xYHaBkRWncvpdbpebd4+WTetmbhM2jI7JrgyO0zUh+KxZDYoN
	L3gSD6hplFQFSOSXIGqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9ZO-0002y2-E9; Tue, 05 Feb 2019 22:51:58 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9ZJ-0002xb-Lt
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:51:56 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B4C3660002;
 Tue,  5 Feb 2019 22:51:43 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Vladimir Vid <vladimir.vid@sartura.hr>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6] arm64: dts: marvell: Add device tree for uDPU board
In-Reply-To: <20190125171707.27742-1-vladimir.vid@sartura.hr>
References: <20190125171707.27742-1-vladimir.vid@sartura.hr>
Date: Tue, 05 Feb 2019 23:51:43 +0100
Message-ID: <87imxx97cw.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_145154_021760_23A9E282 
X-CRM114-Status: GOOD (  20.31  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Luis Torres <luis.torres@methode.com>,
 Jason Cooper <jason@lakedaemon.net>, Paul Arola <paul.arola@telus.com>,
 Vladimir Vid <vladimir.vid@sartura.hr>,
 Scott Roberts <scott.roberts@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vladimir,
 
 On ven., janv. 25 2019, Vladimir Vid <vladimir.vid@sartura.hr> wrote:

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

Looks good, I will apply it on mvebu/dt64 with Andrew reviewed-by flag

Thanks,

Gregory

I have just a minor remark: see below.

> ---
>
> v6 changes:
> - updated LED labels per naming convention (Documentation/leds/leds-class.txt)
>
> ---
>  MAINTAINERS                                   |   5 +
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 164 ++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..21174a13049b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9851,6 +9851,11 @@ F:	drivers/media/platform/meson/ao-cec.c
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
> index 000000000000..2441481643a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -0,0 +1,164 @@
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
> +			label = "udpu:green:power";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		power2 {
> +			label = "udpu:red:power";
> +			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		network1 {
> +			label = "udpu:green:network";
> +			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		network2 {
> +			label = "udpu:red:network";
> +			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		alarm1 {
> +			label = "udpu:green:alarm";
> +			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		alarm2 {
> +			label = "udpu:red:alarm";
> +			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
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
> +	status = "okay";
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,pad-type = "fixed-1-8v";
> +	non-removable;
> +	no-sd;
> +	no-sdio;
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

As you use the new way to declare the partitions then you don't have to
use these 2 properties. It is harmless, and we have the same mistake on
some other platform. However I will fix it while applying the patch: you
don't need to submit a new version.


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
> +
> +	lm75@48 {
> +		status = "okay";
> +		compatible = "lm75";
> +		reg = <0x48>;
> +	};
> +
> +	lm75@49 {
> +		status = "okay";
> +		compatible = "lm75";
> +		reg = <0x49>;
> +	};
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
> +&usb3 {
> +	status = "okay";
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
