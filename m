From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Mar 2017 20:24:14 +0100
Subject: [PATCH 3/3] ARM: dts: sun8i: add device tree for Lichee Pi Zero
 with Dock
In-Reply-To: <20170317154343.39921-4-icenowy@aosc.xyz>
References: <20170317154343.39921-1-icenowy@aosc.xyz>
 <20170317154343.39921-4-icenowy@aosc.xyz>
Message-ID: <20170322192414.rjdu22x3zelvi36a@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:43:43PM +0800, Icenowy Zheng wrote:
> Lichee Pi Zero features a dock, which adds some functions, and should be
> soldered with the core board of Lichee Pi Zero.
> 
> Add support for the dock as a new dts, as soldering is needed to make
> the dock usable and there's functions enabled on the dock that is
> unavailable at the 2.54mm pins of the core board.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/Makefile                         |  3 +-
>  arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 98 ++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 43c27b624f94..de52d403f818 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -878,7 +878,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-h3-orangepi-plus.dtb \
>  	sun8i-h3-orangepi-plus2e.dtb \
>  	sun8i-r16-parrot.dtb \
> -	sun8i-v3s-licheepi-zero.dtb
> +	sun8i-v3s-licheepi-zero.dtb \
> +	sun8i-v3s-licheepi-zero-dock.dtb
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> new file mode 100644
> index 000000000000..956fa47fde53
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
> @@ -0,0 +1,98 @@
> +/*
> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "sun8i-v3s-licheepi-zero.dts"
> +
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Lichee Pi Zero with Dock";
> +	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
> +		     "allwinner,sun8i-v3s";
> +};
> +
> +&leds {
> +	/* The LEDs conflict with MMC1 slot */

How does it conflicts?

> +&mmc1 {
> +	pinctrl-0 = <&mmc1_pins>;
> +	pinctrl-names = "default";
> +	broken-cd;

There's no card-detect on a GPIO?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/6f99466b/attachment.sig>
