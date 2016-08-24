From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Aug 2016 20:24:16 +0200
Subject: [PATCH v4 6/7] arm64: dts: add Pine64 support
In-Reply-To: <20160808172149.30861-7-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
 <20160808172149.30861-7-andre.przywara@arm.com>
Message-ID: <20160824182416.GO8103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 08, 2016 at 06:21:48PM +0100, Andre Przywara wrote:
> The Pine64 is a cost-efficient development board based on the
> Allwinner A64 SoC.
> There are three models: the basic version with Fast Ethernet and
> 512 MB of DRAM (Pine64) and two Pine64+ versions, which both
> feature Gigabit Ethernet and additional connectors for touchscreens
> and a camera. Or as my son put it: "Those are smaller and these are
> missing." ;-)
> The two Pine64+ models just differ in the amount of DRAM
> (1GB vs. 2GB). Since U-Boot will figure out the right size for us and
> patches the DT accordingly we just need to provide one DT for the
> Pine64+.
> 
> [Maxime: Removed the common DTSI and include directly the pine64 DTS]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/Makefile                       |  1 +
>  arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
>  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 48 ++++++++++++++
>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 74 ++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 6e199c9..ddcbf5a 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  dts-dirs += al
> +dts-dirs += allwinner
>  dts-dirs += altera
>  dts-dirs += amd
>  dts-dirs += amlogic
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> new file mode 100644
> index 0000000..1e29a5a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
> new file mode 100644
> index 0000000..e369e83
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (c) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +#include "sun50i-a64-pine64.dts"
> +
> +/ {
> +	model = "Pine64+";
> +	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> new file mode 100644
> index 0000000..077a56f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright (c) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +#include "sun50i-a64.dtsi"
> +
> +/ {
> +	model = "Pine64";
> +	compatible = "pine64,pine64", "allwinner,sun50i-a64";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x20000000>;
> +	};

Isn't that wrong on some Pine64, and filled by U-Boot anyway?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/e07be3b7/attachment.sig>
