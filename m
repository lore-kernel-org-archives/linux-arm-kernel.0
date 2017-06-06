From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Jun 2017 09:42:00 +0200
Subject: [PATCH 4/4] ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7
 board based on RZ/G1M
In-Reply-To: <1496420523-23506-5-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
 <1496420523-23506-5-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdUWJL-oH7wWzjs5O=WrOshdL_AxijBJe66HrYBx7x8F9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biju,

On Fri, Jun 2, 2017 at 6:22 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for iWave RainboW-G20D-Qseven board based on RZ/G1M.

Thanks for your patch!

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -711,6 +711,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
>         r8a73a4-ape6evm.dtb \
>         r8a7740-armadillo800eva.dtb \
>         r8a7743-sk-rzg1m.dtb \
> +       r8a7743-iwg20d-q7.dtb \

Please preserve sort order.

>         r8a7745-sk-rzg1e.dtb \
>         r8a7778-bockw.dtb \
>         r8a7779-marzen.dtb \

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> @@ -0,0 +1,25 @@
> +/*
> + * Device Tree Source for the iWave-RZG1M Qseven carrier board
> + *
> + * Copyright (C) 2017 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a7743-iwg20m.dtsi"
> +
> +/ {
> +       model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
> +       compatible = "iwave,g20d", "renesas,r8a7743";

With my comment on patch [3/4], this should become:

compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";

> +
> +       aliases {
> +               serial0 = &scif0;
> +       };
> +};
> +
> +&scif0 {
> +       status = "okay";
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
