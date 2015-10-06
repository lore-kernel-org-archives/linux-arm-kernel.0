From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 6 Oct 2015 12:15:38 +1100
Subject: [linux-sunxi] [PATCH v2 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <1444054990-15946-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444054990-15946-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGRGNgXyaenitKnZNj4vLsgEDKe0CtTk=KqPADSs9588k1t+GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Oct 6, 2015 at 1:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The C.H.I.P. is a small SBC with an Allwinner R8, 8GB of NAND, 512MB of
> RAM, USB host and OTG, a wifi / bluetooth combo chip, an audio/video jack
> and two connectors to plug additional boards on top of it.

Sorry for the late review, but a couple of minor things stuck out at me.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/Makefile          |   3 +-
>  arch/arm/boot/dts/sun5i-r8-chip.dts | 224 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c7adaa85ef3f..2cf7e593270a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -600,7 +600,8 @@ dtb-$(CONFIG_MACH_SUN5I) += \
>         sun5i-a13-olinuxino.dtb \
>         sun5i-a13-olinuxino-micro.dtb \
>         sun5i-a13-q8-tablet.dtb \
> -       sun5i-a13-utoo-p66.dtb
> +       sun5i-a13-utoo-p66.dtb \
> +       sun5i-r8-chip.dtb
>  dtb-$(CONFIG_MACH_SUN6I) += \
>         sun6i-a31-app4-evb1.dtb \
>         sun6i-a31-colombus.dtb \
> diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
> new file mode 100644
> index 000000000000..08ff70601c79
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> @@ -0,1 +1,224 @@
> +/*
> + * Copyright 2015 Free Electrons
> + * Copyright 2015 NextThing Co
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
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
> +#include "sun5i-a13.dtsi"

Am I missing something or should this include "sun5i-r8.dtsi" instead?

> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       model = "NextThing C.H.I.P.";
> +       compatible = "nextthing,chip", "allwinner,sun5i-r8";
> +
> +       aliases {
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               serial0 = &uart1;
> +               serial1 = &uart3;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";

Should the composite output be enabled here too?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
