From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 18:04:17 +0800
Subject: [PATCH 06/10] ARM: dtsi: add DTSI for AXP223
In-Reply-To: <20161125090921.23138-7-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-7-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v67nBwvQGt9xrZ1GDmFyYCGLmg70sMQStyDKUJZz72Bu7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The AXP223 shares most of its logic with the AXP221 but it has some
> differences for the VBUS driver.

You could also mention this in the dtsi file itself.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp223.dtsi | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 arch/arm/boot/dts/axp223.dtsi
>
> diff --git a/arch/arm/boot/dts/axp223.dtsi b/arch/arm/boot/dts/axp223.dtsi
> new file mode 100644
> index 0000000..f8ce55c
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp223.dtsi
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2016 Free Electrons
> + *
> + * Quentin Schulz <quentin.schulz@free-electrons.com>
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
> +/*
> + * AXP223 Integrated Power Management Chip
> + * http://www.x-powers.com/product/AXP22X.php
> + * http://dl.linux-sunxi.org/AXP/AXP223-en.pdf
> + */
> +
> +#include "axp22x.dtsi"
> +
> +&usb_power_supply {
> +       compatible = "x-powers,axp223-usb-power-supply";
> +};
> --
> 2.9.3
>
