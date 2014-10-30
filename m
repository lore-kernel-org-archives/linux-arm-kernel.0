From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 11:01:52 +0100
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to
 device tree
In-Reply-To: <1414648736-31412-4-git-send-email-horms+renesas@verge.net.au>
References: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
 <1414648736-31412-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW7R_g3hYQSP_VBTXKfbuTZTJEfbZ9ScmE1bzzHKbcPSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:58 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -461,15 +461,19 @@
>                 mstp1_clks: mstp1_clks at e6150134 {
>                         compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
> -                       clocks = <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
> -                                <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
> +                       clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&zg_clk>, <&zs_clk>,
> +                                <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
> +                                <&zs_clk>, <&zs_clk>;
>                         #clock-cells = <1>;
>                         renesas,clock-indices = <
> -                               R8A7794_CLK_TMU1 R8A7794_CLK_PVRSRVKM R8A7794_CLK_TMU3
> -                               R8A7794_CLK_TMU2 R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
> +                               R8A7794_CLK_VCP0 R8A7794_CLK_VPC0 R8A7794_CLK_TMU1
> +                               R8A7794_CLK_PVRSRVKM R8A7794_CLK_2DDMAC R8A7794_CLK_FDP0
> +                               R8A7794_CLK_TMU3 R8A7794_CLK_TMU2 R8A7794_CLK_CMT0
> +                               R8A7794_CLK_TMU0 R8A7794_CLK_VSP1_DU0 R8A7794_CLK_VSP1_S
>                         >;
>                         clock-output-names =
> -                               "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0";
> +                               "vcp0", "vpc0", "tmu1", "pvrsrvkm", "tddmac", "fdp0",

Please match the names with other R-Car Gen2 members:

"2ddmac", "fdp1-0"

> +                               "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du0", "vsps";

(Oops, r8a779[01] still have "vsp1-sy" here)

>                 };
>                 mstp2_clks: mstp2_clks at e6150138 {
>                         compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
> index 7d49531..512ce89 100644
> --- a/include/dt-bindings/clock/r8a7794-clock.h
> +++ b/include/dt-bindings/clock/r8a7794-clock.h
> @@ -26,12 +26,18 @@
>  #define R8A7794_CLK_MSIOF0             0
>
>  /* MSTP1 */
> +#define R8A7794_CLK_VCP0               1
> +#define R8A7794_CLK_VPC0               3
>  #define R8A7794_CLK_TMU1               11
>  #define R8A7794_CLK_PVRSRVKM           12
> +#define R8A7794_CLK_2DDMAC             15
> +#define R8A7794_CLK_FDP0               19

R8A7794_CLK_FDP1_0

>  #define R8A7794_CLK_TMU3               21
>  #define R8A7794_CLK_TMU2               22
>  #define R8A7794_CLK_CMT0               24
>  #define R8A7794_CLK_TMU0               25
> +#define R8A7794_CLK_VSP1_DU0           28
> +#define R8A7794_CLK_VSP1_S             31






-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
