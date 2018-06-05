From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 5 Jun 2018 05:56:02 +0300
Subject: [PATCH] ARM: dts: armada388-helios4
In-Reply-To: <20180605011343.14999-1-dennis@ausil.us>
References: <20180605011343.14999-1-dennis@ausil.us>
Message-ID: <20180605025602.dt5nhl65ak7ij4n7@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dennis,

On Mon, Jun 04, 2018 at 08:13:43PM -0500, Dennis Gilmore wrote:
> The helios4 is a Armada388 based nas board designed by SolidRun and
> based on their SOM. It is sold by kobol.io the dts file came from
> https://raw.githubusercontent.com/armbian/build/master/patch/kernel/mvebu-default/95-helios4-device-tree.patch
> I added a SPDX license line to match the clearfog it says it was based
> on and a compatible line for "solidrun,helios4"
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/armada-388-helios4.dts | 315 +++++++++++++++++++++++
>  2 files changed, 316 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-388-helios4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e2424957809..490bfd586198 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1123,6 +1123,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
>  	armada-388-clearfog-pro.dtb \
>  	armada-388-db.dtb \
>  	armada-388-gp.dtb \
> +	armada-388-helios4.dtb \
>  	armada-388-rd.dtb
>  dtb-$(CONFIG_MACH_ARMADA_39X) += \
>  	armada-398-db.dtb
> diff --git a/arch/arm/boot/dts/armada-388-helios4.dts b/arch/arm/boot/dts/armada-388-helios4.dts
> new file mode 100644
> index 000000000000..a6d6996e1378
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-388-helios4.dts
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Device Tree file for Helios4
> + * based on SolidRun Clearfog revision A1 rev 2.0 (88F6828)
> + *
> + *  Copyright (C) 2017
> + *
> + */
> +
> +/dts-v1/;
> +#include "armada-388.dtsi"
> +#include "armada-38x-solidrun-microsom.dtsi"
> +
> +/ {
> +	model = "Helios4";
> +	compatible = "solidrun,helios4", "marvell,armada388",

SolidRun is not the producer of the Helios4 carrier board. So I think 
"kobol,helios4" makes more sense. This is just like the "auvidea,h100" 
compatible string for Auvidea H100 which is also using a SolidRun SOM.

baruch

> +		"marvell,armada385", "marvell,armada380";
> +

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
