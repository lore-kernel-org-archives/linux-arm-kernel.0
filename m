From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Mar 2015 23:02:38 +0100
Subject: [PATCH 1/2] ARM: dts: sun7i: Add dts file for Wexler TAB7200
In-Reply-To: <1425503808-28567-1-git-send-email-mamlinav@gmail.com>
References: <1425456947-4152-1-git-send-email-mamlinav@gmail.com>
 <1425503808-28567-1-git-send-email-mamlinav@gmail.com>
Message-ID: <20150305220238.GC4522@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 12:16:48AM +0300, Aleksei Mamlin wrote:
> This patch add support for Wexler TAB7200 tablet.
> 
> The Wexler TAB7200 is a A20 based tablet with 7 inch display(800x480),
> capacitive touchscreen(5 fingers), 1G RAM, 4G NAND, micro SD card slot,
> mini HDMI port, 3.5mm audio plug, 1 USB OTG port and 1 USB 2.0 port.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                     |   3 +-
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 181 +++++++++++++++++++++++++
>  2 files changed, 183 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index beac15f..f6dc2ac 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -550,7 +550,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-olinuxino-lime2.dtb \
>  	sun7i-a20-olinuxino-micro.dtb \
>  	sun7i-a20-pcduino3.dtb \
> -	sun7i-a20-pcduino3-nano.dtb
> +	sun7i-a20-pcduino3-nano.dtb \
> +	sun7i-a20-wexler-tab7200.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a23-ippo-q8h-v5.dtb \
>  	sun8i-a23-ippo-q8h-v1.2.dtb
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> new file mode 100644
> index 0000000..b197d57
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -0,0 +1,181 @@
> +/*
> + * Copyright 2015 Aleksei Mamlin
> + * Aleksei Mamlin <mamlinav@gmail.com>
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
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>

You don't seem to be using the pinctrl header.

Also, next time, please mention the version and provide a changelog
for your patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/cca5621a/attachment.sig>
