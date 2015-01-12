From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 12:24:29 +0100
Subject: [PATCH 3/3] ARM: dts: sun8i: Add dts file for Ippo Q8H v1.2
 tablets
In-Reply-To: <1420661775-20424-3-git-send-email-hdegoede@redhat.com>
References: <1420661775-20424-1-git-send-email-hdegoede@redhat.com>
 <1420661775-20424-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150112112429.GI4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 07, 2015 at 09:16:15PM +0100, Hans de Goede wrote:
> The Ippo Q8H v1.2 is almost identical to the v5, still it needs a separate
> dtb file since some gpio-s surrounding the wlan/bluetooth are different,
> it uses different camera sensors, and different DRAM timings.
> 
> Note that atm neither the wlan/bluetooth nor the camera are supported, so
> atm their is no difference between the dts files, but because of the different
> DRAM timings there are already separate u-boot configs for the 2 different
> versions, and the 1.2 config refers to sun8i-a23-ippo-q8h-v1.2.dtb to be
> future proof, so we need to provide a sun8i-a23-ippo-q8h-v1.2.dtb file.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/Makefile                    |  3 +-
>  arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts | 58 +++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4142831..7f66bab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -478,7 +478,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-olinuxino-micro.dtb \
>  	sun7i-a20-pcduino3.dtb
>  dtb-$(CONFIG_MACH_SUN8I) += \
> -	sun8i-a23-ippo-q8h-v5.dtb
> +	sun8i-a23-ippo-q8h-v5.dtb \
> +	sun8i-a23-ippo-q8h-v1.2.dtb
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
> new file mode 100644
> index 0000000..7056fc2
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
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
> +/*
> + * The Ippo Q8H v1.2 is almost identical to the v5, still it needs a separate
> + * dtb file since some gpio-s surrounding the wlan/bluetooth are different,
> + * and it uses different camera sensors.
> + */
> +
> +#include "sun8i-a23-ippo-q8h-v5.dts"
> +
> +/ {
> +	model = "Ippo Q8H Dual Core Tablet (v1.2)";

Maybe we should have a separate compatible too then, if we ever need
to differentiate the two for any other reason (quirks, mostly)?

Something like
  compatible = "ippo,q8h-v5", "ippo,q8h", "allwinner,sun8i-a23";
and
  compatible = "ippo,q8h-v1.2", "ippo,q8h", "allwinner,sun8i-a23";

in their respective DTs?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/4b081379/attachment-0001.sig>
