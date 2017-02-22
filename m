From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 08:44:06 -0600
Subject: [PATCH 2/2] ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV
In-Reply-To: <20170212193247.22705-3-carlo@caione.org>
References: <20170212193247.22705-1-carlo@caione.org>
 <20170212193247.22705-3-carlo@caione.org>
Message-ID: <20170222144406.zycqtc77dygavh3q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 08:32:47PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch adds support for the HwaCom AmazeTV set-top-box. The
> hardware configuration is really similar to the other GXL boards but
> for this hardware we need to limit the max-frequency of the eMMC to
> have it working.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts  | 201 +++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 9b2b41a..c369a55 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -47,3 +47,4 @@ Board compatible values:
>    - "amlogic,q201" (Meson gxm s912)
>    - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
>    - "nexbox,a1" (Meson gxm s912)
> +  - "hwacom,amazetv" (Meson gxl s905x)
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 0d7bfbf..2932755 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-hwacom-amazetv.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts
> new file mode 100644
> index 0000000..4499789
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts
> @@ -0,0 +1,201 @@
> +/*
> + * Copyright (c) 2017 Carlo Caione
> + * Copyright (c) 2016 Andreas F?rber
> + * Copyright (c) 2016 BayLibre, Inc.
> + * Author: Neil Armstrong <narmstrong@kernel.org>
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

I'm going to start asking people to use SPDX tags and you are the first. :)

SPDX-License-Identifier: GPL2.0+ OR MIT

Note that is really MIT license and not X11 which has additional 
clauses.

> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905x.dtsi"
> +
> +/ {
> +	compatible = "hwacom,amazetv", "amlogic,s905x", "amlogic,meson-gxl";
> +	model = "HWACOM AMAZETV (S905X)";

Why yelling the model?

Rob
