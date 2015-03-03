From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Mar 2015 08:16:35 +0100
Subject: [PATCH] ARM: sun6i: dt: Add new Mele I7 device
In-Reply-To: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
References: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
Message-ID: <20150303071635.GC4713@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 28, 2015 at 02:48:05PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The Mele I7 is a Allwinner A31 based Android TV box, with 1G RAM,
> 8GB NAND flash, a RTL8188etv wifi chip, 3 USB Host ports using
> USB-A receptacles, a micro USB-B receptacle for USB OTG, HDMI out,
> a TRS connector for A/V, SPDIF and IrDA.
> 
> This patch adds basic support for the device, more information can
> be found here (http://linux-sunxi.org/Mele_I7).
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/sun6i-a31-i7.dts | 150 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun6i-a31-i7.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index eae7706..8d9d5ea 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -532,6 +532,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>  	sun6i-a31-app4-evb1.dtb \
>  	sun6i-a31-colombus.dtb \
>  	sun6i-a31-hummingbird.dtb \
> +	sun6i-a31-i7.dtb \
>  	sun6i-a31-m9.dtb \
>  	sun6i-a31s-cs908.dtb
>  dtb-$(CONFIG_MACH_SUN7I) += \
> diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
> new file mode 100644
> index 0000000..43fdcd5
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright 2015 Marcus Cooper <codekipper@gmail.com>
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
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
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
> +/dts-v1/;
> +#include "sun6i-a31.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "Mele I7 Quad top set box";
> +	compatible = "mele,i7", "allwinner,sun6i-a31";
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";

Using earlyprintk by default is a bad idea if the kernel is configured
with DEBUG_LL support for another SoC.

I removed it and applied the patche.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/7752827a/attachment-0001.sig>
