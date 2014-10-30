From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 10:54:04 +0100
Subject: [PATCH 1/3] ARM: shmobile: r8a7794: Add SGX clock to device tree
In-Reply-To: <1414648736-31412-2-git-send-email-horms+renesas@verge.net.au>
References: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
 <1414648736-31412-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUkqmbuLTjGU5DxyrxroKXHKVYtn9dRfbOxho1Rr1_1rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:58 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -461,16 +461,15 @@
>                 mstp1_clks: mstp1_clks at e6150134 {
>                         compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
> -                       clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
> -                                <&cp_clk>,
> -                                <&zs_clk>, <&zs_clk>, <&zs_clk>;
> +                       clocks = <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
> +                                <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
>                         #clock-cells = <1>;
>                         renesas,clock-indices = <
> -                               R8A7794_CLK_TMU1 R8A7794_CLK_TMU3 R8A7794_CLK_TMU2
> -                               R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
> +                               R8A7794_CLK_TMU1 R8A7794_CLK_PVRSRVKM R8A7794_CLK_TMU3
> +                               R8A7794_CLK_TMU2 R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
>                         >;
>                         clock-output-names =
> -                               "tmu1", "tmu3", "tmu2", "cmt0", "tmu0";
> +                               "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0";

"3dg"

> --- a/include/dt-bindings/clock/r8a7794-clock.h
> +++ b/include/dt-bindings/clock/r8a7794-clock.h
> @@ -27,6 +27,7 @@
>
>  /* MSTP1 */
>  #define R8A7794_CLK_TMU1               11
> +#define R8A7794_CLK_PVRSRVKM           12

R8A7794_CLK_3DG

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
