From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Feb 2015 11:05:57 +0000
Subject: [PATCH] ARM: shmobile: silk: initial device tree
In-Reply-To: <1608366.HtA9yBksdO@wasted.cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
Message-ID: <20150202110557.GC7459@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:52:16PM +0000, Sergei Shtylyov wrote:
> Add the initial device tree for the R8A7794 SoC based SILK low cost board.
> SCIF2 serial port support is included, so that the serial console can work.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20150129-v3.19-rc6' tag of Simon
> Horman's 'renesas.git' repo.
> 
>  arch/arm/boot/dts/Makefile         |    1 
>  arch/arm/boot/dts/r8a7794-silk.dts |   41 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/Makefile
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/Makefile
> +++ renesas/arch/arm/boot/dts/Makefile
> @@ -421,6 +421,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += eme
>  	r8a7791-koelsch.dtb \
>  	r8a7791-porter.dtb \
>  	r8a7794-alt.dtb \
> +	r8a7794-silk.dtb \
>  	sh73a0-kzm9g.dtb
>  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
>  	socfpga_arria10_socdk.dtb \
> Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
> @@ -0,0 +1,41 @@
> +/*
> + * Device Tree Source for the SILK board
> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + * Copyright (C) 2014-2015 Renesas Solutions Corp.
> + * Copyright (C) 2014-2015 Cogent Embedded, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a7794.dtsi"
> +
> +/ {
> +	model = "SILK";

Shouldn't that have a "Renesas" prefix or something like that?

It's unlikely that there will be another board called "SILK", but it
does make it hard for someone to get an idea of what the board is from
the model string alone.

Mark.
