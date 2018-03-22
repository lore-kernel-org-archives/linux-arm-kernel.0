From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Mar 2018 13:49:47 +0100
Subject: [PATCH v2 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree
 file
In-Reply-To: <1521719091-25157-7-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
 <1521719091-25157-7-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdWG5gy25MXn2kEP0XO0xWg5Ztou2DrzLXwZWfhYRBTbCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1 SoC Family of devices
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "renesas,rzn1";

As per your binding, this should be "renesas,r9a06g032"

> +       soc {

> +               sysctrl: sysctrl at 4000c000 {
> +                       compatible = "renesas,rzn1-sysctrl", "syscon",

Missing "renesas,r9a06g032-sysctrl".

> +                                       "simple-mfd";
> +                       reg = <0x4000c000 0x1000>;
> +
> +                       reboot {
> +                               compatible = "renesas,rzn1-reboot";

Missing "renesas,r9a06g032-reboot".

> +                       };
> +               };


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
