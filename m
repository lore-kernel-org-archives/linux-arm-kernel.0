From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Feb 2018 10:00:42 +0100
Subject: [PATCH v4] ARM: sun8i: h2+: add support for Banana Pi M2 Zero
 board
In-Reply-To: <20180206131647.41700-1-icenowy@aosc.io>
References: <20180206131647.41700-1-icenowy@aosc.io>
Message-ID: <20180208090042.364is5ctofhuao4i@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 09:16:47PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
> factor and GPIO holes similar to Raspberry Pi Zero.
> 
> It features:
> - Allwinner H2+ SoC
> - Single-chip (16-bit) 512MiB DDR3 DRAM
> - Ampak AP6212 Wi-Fi/Bluetooth module
> - MicroSD slot
> - Two MicroUSB Type-B ports (one can only be used to power the board and
>   the other features OTG functionality)
> - Two keys, a reset and a GPIO-connected key.
> - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
> - CSI connector to connect the camera sensor provided by Sinovoip.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Use SPDX license identifier.
> 
> Changes in v3:
> - Add comments about Vbus problem in &usbphy node.
> 
> Changes in v2:
> - Use high active SD card detect on the production batch.
> 
>  arch/arm/boot/dts/Makefile                         |   1 +
>  .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 126 +++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..d5a17e6e8b0f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -974,6 +974,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a83t-cubietruck-plus.dtb \
>  	sun8i-a83t-tbs-a711.dtb \
>  	sun8i-h2-plus-orangepi-r1.dtb \
> +	sun8i-h2-plus-bananapi-m2-zero.dtb \
>  	sun8i-h2-plus-orangepi-zero.dtb \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> new file mode 100644
> index 000000000000..e2ee65a5bf92
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * Based on sun8i-h3-bananapi-m2-plus.dts, which is:
> + *   Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Sorry to be a bit picky about this, but this should be your very first
line, see arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts for example.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/08e284ad/attachment.sig>
