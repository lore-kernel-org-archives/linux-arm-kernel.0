From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 12 Sep 2016 18:28:11 +0200
Subject: [PATCH 2/3] ARM64: dts: amlogic: Add basic support for Amlogic
 S905X
In-Reply-To: <20160903082227.30559-3-narmstrong@baylibre.com>
References: <20160903082227.30559-1-narmstrong@baylibre.com>
 <20160903082227.30559-3-narmstrong@baylibre.com>
Message-ID: <7e27e8c0-bb18-40d8-10d6-3928e66815c7@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 03.09.2016 um 10:22 schrieb Neil Armstrong:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch introduces the basic support for the Amlogic S905X (Meson
> GXL) and for the Amlogic evaluation board P212.
> No documentation has been released yet for this SoC, so for now only the
> bare minimum has been added in the DT.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |  5 ++
>  arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>  .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      | 70 ++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   | 48 +++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 48 +++++++++++++++
>  5 files changed, 172 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index fcc6f6c..702c911 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -17,6 +17,10 @@ Boards with the Amlogic Meson GXBaby SoC shall have the following properties:
>    Required root node property:
>      compatible: "amlogic,meson-gxbb";
>  
> +Boards with the Amlogic Meson GXL SoC shall have the following properties:
> +  Required root node property:
> +    compatible: "amlogic,meson-gxl-s905x", "amlogic,meson-gxl";

Can we please use "amlogic,s905x", "amlogic,meson-gxl"? No need to
complicate the name. Also affects .dtsi and .dts below.

> +
>  Board compatible values:
>    - "geniatech,atv1200" (Meson6)
>    - "minix,neo-x8" (Meson8)
> @@ -28,3 +32,4 @@ Board compatible values:
>    - "hardkernel,odroid-c2" (Meson gxbb)
>    - "amlogic,p200" (Meson gxbb)
>    - "amlogic,p201" (Meson gxbb)
> +  - "amlogic,p212" (Meson gxl s905x)
[...]
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> new file mode 100644
> index 0000000..e0df975
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +#include "meson-gxl-s905x.dtsi"
> +
> +/ {
> +	compatible = "amlogic,p212", "amlogic,meson-gxl-s905x", "amlogic,meson-gxl";
> +	model = "Amlogic Meson GXL (S905X) P212 Development Board";

Is that its official name? No objection, just wondering whether we need
both GXL and S905X in the name, and then again the SoC name at all if
the P212 is unique. Haven't compared the previous Pxxx ones.

> +
> +	aliases {
> +		serial0 = &uart_AO;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +};
> +
> +/* This UART is brought out to the DB9 connector */
> +&uart_AO {
> +	status = "okay";
> +};
> +

Trailing white line - please watch out for that, git-am will complain.

> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> new file mode 100644
> index 0000000..b9e94f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
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
> +#include "meson-gxl.dtsi"
> +
> +/ {
> +	compatible = "amlogic,meson-gxl", "amlogic,meson-gxl-s905x";

This needs to be reversed.

> +};
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
