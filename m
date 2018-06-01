From: jagan@openedev.com (Jagan Teki)
Date: Fri, 1 Jun 2018 23:46:05 +0530
Subject: [linux-sunxi] [PATCH] arm: sun4i: Add support for Pengpod 1000
 tablet
In-Reply-To: <20180601175538.16716-1-rah@settrans.net>
References: <20180601175538.16716-1-rah@settrans.net>
Message-ID: <29aec3c3-61af-b814-351b-6faf31a8cea3@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2018 11:25 PM, Bob Ham wrote:
> This is initial support for the Pengpod 1000 tablet.  The display is
> not currently working but the UART, SD card and USB all work fine.
> 
> Signed-off-by: Bob Ham <rah@settrans.net>
> ---
>   arch/arm/boot/dts/Makefile                   |   1 +
>   arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts | 232 +++++++++++++++++++++++++++
>   2 files changed, 233 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..e6e93e7ffc8b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -893,6 +893,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>   	sun4i-a10-olinuxino-lime.dtb \
>   	sun4i-a10-pcduino.dtb \
>   	sun4i-a10-pcduino2.dtb \
> +	sun4i-a10-pengpod-1000.dtb \
>   	sun4i-a10-pov-protab2-ips9.dtb
>   dtb-$(CONFIG_MACH_SUN5I) += \
>   	sun5i-a10s-auxtek-t003.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts b/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> new file mode 100644
> index 000000000000..94560400114d
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> @@ -0,0 +1,232 @@
> +/*
> + * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
> + * Copyright 2017 Robert Ham <rah@settrans.net>
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

We need to use SPDX-License for new dts files.
