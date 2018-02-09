From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Feb 2018 08:42:10 +0100
Subject: [PATCH 10/11] arm64: dts: renesas: initial Condor board device
 tree
In-Reply-To: <c35dca71-fc63-7628-d483-ad690bea7ced@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <c35dca71-fc63-7628-d483-ad690bea7ced@cogentembedded.com>
Message-ID: <CAMuHMdWeRBYK5f4VpfY-YCDASk8RqVy2VCQm51cyR8VUXSxfeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Feb 2, 2018 at 7:46 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial device  tree for  the R8A77980 SoC based Condor board.
> The board has 1 debug serial port (SCIF0); include support for it, so
> that the serial console can work.
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

> --- /dev/null
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the Condor board
> + *
> + * Copyright (C) 2018 Renesas Electronics Corp.
> + * Copyright (C) 2018 Cogent Embedded, Inc.
> + */
> +
> +/dts-v1/;
> +#include "r8a77980.dtsi"
> +
> +/ {
> +       model = "Renesas Condor board based on r8a77980";
> +       compatible = "renesas,condor", "renesas,r8a77980";
> +
> +       aliases {
> +               serial0 = &scif0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory at 48000000 {
> +               device_type = "memory";
> +               /* first 128MB is reserved for secure area. */
> +               reg = <0x0 0x48000000 0x0 0x38000000>;

According to the Samsung website, the LPDDR is a 16 Gib part, i.e. 2 GiB.
Is there any specific reason you're limiting memory to 1 GiB?

> +       };

With the above resolved:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
