From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Feb 2016 15:25:47 +0100
Subject: [PATCH] arm64: dts: r8a7795: Add CAN external clock support
In-Reply-To: <1456496023-16240-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456496023-16240-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <CAMuHMdXJRN2kF2r=bqcY8v87aYHj_OKr2=5vzcfoHwvr02Y2CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ramesh,

On Fri, Feb 26, 2016 at 3:13 PM, Ramesh Shanmugasundaram
<ramesh.shanmugasundaram@bp.renesas.com> wrote:
> Adds external CAN clock node for r8a7795. This clock can be used as
> fCAN clock of CAN and CAN FD controller.
>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index a7315eb..5167a6c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -115,6 +115,13 @@
>                 clock-frequency = <0>;
>         };
>
> +       /* External CAN clock - to be overridden by boards that provide it */
> +       can_clk: can {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;

As this is an optional clock, it should have

        status = "disabled";

> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
