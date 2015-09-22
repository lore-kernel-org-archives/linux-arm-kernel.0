From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 18:00:53 +0200
Subject: [PATCH 4/4] ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner
In-Reply-To: <1442936337-3104-5-git-send-email-vishnupatekar0510@gmail.com>
References: <1442936337-3104-1-git-send-email-vishnupatekar0510@gmail.com>
 <1442936337-3104-5-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20150922160053.GM4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 11:38:57PM +0800, Vishnu Patekar wrote:
> H8Homlet Proto v2.0 Board is A83T Dev Board by Allwinner.
> It has UART, ethernet, USB, HDMI, etc ports on it.
> 
> It's name is confusing, Its A83T board however,"H8_HOMLET_PROTO_V2"
> printed on board.
> 
> A83T patches are tested on this board.
> It has UART, ethernet, USB, HDMI, etc ports on it.
> 
> For FEL mode it needs USB A-A(Male) cable. I used uart0 which
> is multiplexed to microsd pins PF2 and PF4.

Is there no other UART on the device?

> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  5 +-
>  .../boot/dts/sun8i-a83t-allwinner-homlet-v20.dts   | 69 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sun8i-a83t-allwinner-homlet-v20.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b276174..9585a58 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -634,7 +634,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a33-ga10h-v1.1.dtb \
>  	sun8i-a33-ippo-q8h-v1.2.dtb \
>  	sun8i-a33-q8-tzx-723q4.dtb \
> -	sun8i-a33-sinlinx-sina33.dtb
> +	sun8i-a33-sinlinx-sina33.dtb \
> +	sun8i-a83t-allwinner-homlet-v20.dtb

we probably want to mention the h8 in here too, and the v2 is enough.

>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> @@ -679,7 +680,7 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
>  	uniphier-ph1-ld6b-ref.dtb \
>  	uniphier-ph1-pro4-ref.dtb \
>  	uniphier-ph1-sld3-ref.dtb \
> -	uniphier-ph1-sld8-ref.dtb 
> +	uniphier-ph1-sld8-ref.dtb

Uh ?

>  dtb-$(CONFIG_ARCH_VERSATILE) += \
>  	versatile-ab.dtb \
>  	versatile-pb.dtb
> diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-homlet-v20.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-homlet-v20.dts
> new file mode 100644
> index 0000000..bbc2ab9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-homlet-v20.dts
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright 2015 Vishnu Patekar
> + * Vishnu Patekar <vishnupatekar0510@gmail.com>
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
> +#include "sun8i-a83t.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>

Do you need those headers?

> +
> +/ {
> +	model = "Allwinner A83T H8Homlet Proto Dev Board v2.0";
> +	compatible = "allwinner,homletv2", "allwinner,sun8i-a83t";

                                ^ Please add a dash here

> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		bootargs = "earlyprintk console=ttyS0,115200";

console is useless here, and please remove earlyprintk. It will make
your kernel crash if the image is configured for another SoC.

> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/dd88d029/attachment.sig>
