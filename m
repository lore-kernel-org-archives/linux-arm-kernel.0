From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Nov 2014 10:32:07 -0600
Subject: [PATCH] ARM: dts: Add am57xx-beagle-x15
In-Reply-To: <1415290702-11353-1-git-send-email-nm@ti.com>
References: <1415290702-11353-1-git-send-email-nm@ti.com>
Message-ID: <20141106163207.GF16896@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 10:18:22AM -0600, Nishanth Menon wrote:
> BeagleBoard-X15 is the next generation Open Source Hardware
> BeagleBoard based on TI's AM5728 SoC featuring dual core 1.5GHZ A15
> processor. The platform features 2GB DDR3L (w/dual 32bit busses),
> eSATA, 3 USB3.0 ports, integrated HDMI (1920x108 at 60), separate LCD
> port, video In port, 4GB eMMC, uSD, Analog audio in/out, dual 1G
> Ethernet.
> 
> For more information, refer to:
> BeagleBoard-X15 Wiki:
> http://www.elinux.org/Beagleboard:BeagleBoard-X15
> 
> AM5728 is part of the Sitara product family whose additional details
> will be available: http://www.ti.com/lsds/ti/arm/overview.page
> 
> Technical Reference Manual for AM5728 is public domain at:
> http://www.ti.com/lit/spruhz6
> 
> Just add basic support for the moment, the following updates are needed:
>   i)	Ethernet - depends on SoC dts fixes
>   ii)	USB Client (USB2) - depends on GPIO extcon
>   ii)	HDMI - additional driver fixes pending
>   iii)	Audio - additional driver fixes pending
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Tested with omap2plus_defconfig modified as: http://slexy.org/view/s2DRTzUwjj
> boot log: http://slexy.org/raw/s25Grf1uoo
> based on 3.18-rc1 tag.
> 
> Support for u-boot has been posted as well: (series ending
> http://patchwork.ozlabs.org/patch/407552/ )
> 
> Side note: this patch generates a few unrelated checkpatch warning for
> compatible which probably is part of appropriate driver documentation
> fixes (functionality is already present).
> 
>  arch/arm/boot/dts/Makefile              |    1 +
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |  405 +++++++++++++++++++++++++++++++
>  2 files changed, 406 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 38c89ca..eee1e4f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -347,6 +347,7 @@ dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
>  	omap5-sbc-t54.dtb \
>  	omap5-uevm.dtb
>  dtb-$(CONFIG_SOC_DRA7XX) += dra7-evm.dtb \
> +	am57xx-beagle-x15.dtb \
>  	dra72-evm.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
>  	orion5x-lacie-ethernet-disk-mini-v2.dtb \
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> new file mode 100644
> index 0000000..1f1875b
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -0,0 +1,405 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "dra74x.dtsi"
> +#include <dt-bindings/clk/ti-dra7-atl.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "TI AM5728 BeagleBoard-X15";
> +	compatible = "ti,am572x-beagle-x15", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
> +
> +	aliases {
> +		rtc0 = &mcp_rtc;
> +		rtc1 = &tps659038_rtc;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>; /* 1GB to start. Target 2GB */

1GiB ? Why would you put this here btw ? u-boot fills this one up.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/3acfe3bd/attachment.sig>
