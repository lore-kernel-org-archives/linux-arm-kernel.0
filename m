From: mbrugger@suse.com (Matthias Brugger)
Date: Mon, 25 Apr 2016 11:23:38 +0200
Subject: [PATCH 3/5] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <1461574157-23580-4-git-send-email-vladimir.murzin@arm.com>
References: <1461574157-23580-1-git-send-email-vladimir.murzin@arm.com>
 <1461574157-23580-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <571DE21A.5010502@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/04/16 10:49, Vladimir Murzin wrote:
> Application Notes 385 and 386 shares the same memory map and features
> except the CPU is used. AN385 is supplied with Cortex-M3 CPU and AN386
> is supplied with Cortex-M4.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>   arch/arm/boot/dts/Makefile       |    1 +
>   arch/arm/boot/dts/mps2-an385.dts |   92 +++++++++++++++
>   arch/arm/boot/dts/mps2.dtsi      |  241 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 334 insertions(+)
>   create mode 100644 arch/arm/boot/dts/mps2-an385.dts
>   create mode 100644 arch/arm/boot/dts/mps2.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 95c1923..1efa5a2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -253,6 +253,7 @@ dtb-$(CONFIG_ARCH_MMP) += \
>   dtb-$(CONFIG_MACH_MESON8B) += \
>   	meson8b-mxq.dtb \
>   	meson8b-odroidc1.dtb
> +dtb-$(CONFIG_ARCH_MPS2) += mps2-an385.dtb
>   dtb-$(CONFIG_ARCH_MOXART) += \
>   	moxart-uc7112lx.dtb
>   dtb-$(CONFIG_SOC_IMX1) += \
> diff --git a/arch/arm/boot/dts/mps2-an385.dts b/arch/arm/boot/dts/mps2-an385.dts
> new file mode 100644
> index 0000000..d7cb594
> --- /dev/null
> +++ b/arch/arm/boot/dts/mps2-an385.dts
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (C) 2015 ARM Limited
> + *
> + * Author: Vladimir Murzin <vladimir.murzin@arm.com>
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
> +
> +#include "mps2.dtsi"
> +
> +/ {
> +	model = "ARM MPS2 Application Note 385/386";
> +	compatible = "arm,mps2";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		bootargs = "rdinit=/sbin/init earlycon";

The rootfs should be independent from the board.
In my opinion, this type of bootargs should not be part of the DTS.

Regards,
Matthias
