From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 14:11:29 +0200
Subject: [PATCH] arm64: dts: r8a7795: Add OPPs table for cpu devices
In-Reply-To: <1501853180-23939-1-git-send-email-horms+renesas@verge.net.au>
References: <1501853180-23939-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVhRLLU=VW6xp2DtXXjjtxK_or0jRon0nbKJQiqqGfbwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

2017-08-04 15:26 GMT+02:00 Simon Horman <horms+renesas@verge.net.au>:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> Current, OPP tables are defined temporary,
> they are being evaluated and adjust in future.
>
> Based in part on work by Hien Dang.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [simon: consolidated sseveral patches into one]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 309 +++++++++++++++++++++++++++++++
>  1 file changed, 309 insertions(+)
>
> I am not aware of any build-time depdendencies of this patch.
>
> This patch has run-time depdnencies on:
> * [PATCH] cpufreq: rcar: Add support for R8A7795 SoC
> * [PATCH 0/4] r8a7795: Add Z and Z2 clock support
>
> I have provided an integration patch with this patch, those DTS changes,
> and Renesas clock updates also depended on by the DTS changes. The result
> is working CPUFreq for the r8a7795 (R-Car H3) ES1.0.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a7795-cpufreq
>
> A description of steps taken to lightly exercise the above can be found here:
>
> http://elinux.org/Tests:R-CAR-GEN3-CPUFreq
>
> If this work is acceptable I plan to follow up with patches to
> enable CPUFreq on the r8a7796 (R-Car M3-W).
>
> This patch is based on renesas-arm64-dt-for-v4.14
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index a87ae76880ab..f34da4c9ea52 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi

> @@ -126,6 +152,289 @@
>                 };
>         };
>
> +       cluster0_opp_tb0: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp at 500000000 {

No complaints from "make W=1 dtbs" due to unit-address without reg property?

=> "opp-500000000 { ... };"

> +                       opp-hz = /bits/ 64 <500000000>;
> +                       opp-microvolt = <830000>;
> +                       clock-latency-ns = <300000>;
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
