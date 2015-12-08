From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 9 Dec 2015 09:56:19 +1100
Subject: [linux-sunxi][PATCH 2/2] ARM: dts: sun4i: Add rikomagic mk802+
 board
In-Reply-To: <1449600534-5098-3-git-send-email-codekipper@gmail.com>
References: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
 <1449600534-5098-3-git-send-email-codekipper@gmail.com>
Message-ID: <CAGRGNgWpP5u1s2jDUX6F=FqxGhvpjWE1bpJMMcx7hFvs0=E7sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On Wed, Dec 9, 2015 at 5:48 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The Rikomagic mk802+ is an Allwinner A10 based hdmi tv-stick, it features
> 1G RAM, 4G nand, a mini-hdmi female connector, USB-A receptacle, mini-usb
> receptacle (OTG), USB-wifi and an internal microphone. Like the original
> mk802, it does not use any pmic.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts | 50 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ee8a1dc..f1cb0f8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -600,6 +600,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>         sun4i-a10-marsboard.dtb \
>         sun4i-a10-mini-xplus.dtb \
>         sun4i-a10-mk802.dtb \
> +       sun4i-a10-mk802-1gb.dtb \
>         sun4i-a10-mk802ii.dtb \
>         sun4i-a10-olinuxino-lime.dtb \
>         sun4i-a10-pcduino.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts b/arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts
> new file mode 100644
> index 0000000..eb77633
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802-1gb.dts
> @@ -0,0 +1,50 @@
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
> +#include "sun4i-a10-mk802.dtsi"
> +
> +/ {
> +       model = "Rikomagic MK802+";
> +       compatible = "rikomagic,mk802-1gb", "allwinner,sun4i-a10";
> +
> +};

Are there any differences between the Rikomagic and the generic MK802?

You could just add another compatible to the original MK802 dts if there aren't.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
