From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Sep 2017 10:59:48 +0200
Subject: [PATCH 05/11] arm64: dts: renesas: initial R8A77970 SoC device
 tree
In-Reply-To: <20170912210523.663877115@cogentembedded.com>
References: <20170912210523.663877115@cogentembedded.com>
Message-ID: <CAMuHMdUzO_oHscsLntd0VaKAOCXU00MyidvZ_A-rR2+UHtKc9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Sep 12, 2017 at 10:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The initial R8A77970 SoC device tree including Cortex-A53 CPU, GIC, timer,
> CPG, RST, and SYSC.
>
> Based on the original (and large) patch by Daisuke Matsushita
> <daisuke.matsushita.ns@hitachi.com>.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm64/boot/dts/renesas/r8a77970.dtsi |  126 ++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> @@ -0,0 +1,126 @@
> +/*
> + * Device Tree Source for the r8a77970 SoC
> + *
> + * Copyright (C) 2016-2017 Renesas Electronics Corp.
> + * Copyright (C) 2017 Cogent Embedded, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

arm-gic.h includes irq.h.

> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +#include <dt-bindings/power/r8a77970-sysc.h>

You can avoid the dependency on the above header, which will go upstream
through a different branch, by hardcoding the power area indices for the
initial submission, like you already did for the CPG core clocks.

> +
> +/ {
> +       compatible = "renesas,r8a77970";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       psci {
> +               compatible = "arm,psci-1.0";

PSCI 1.0 is backwards compatible with PSI 0.2:

    compatible = "arm,psci-1.0", "arm,psci-0.2";

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
