From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 2 Apr 2015 09:59:47 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add EtherAVB clock
In-Reply-To: <2142150.nOzfK74FZR@wasted.cogentembedded.com>
References: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
 <2142150.nOzfK74FZR@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVYtsEg8H+=bBD3TBRVSAwOBaM8pcmgOUyh=qpwYOuDvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Mar 30, 2015 at 11:58 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1193,16 +1193,18 @@
>                         compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
>                         clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
> -                                <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
> +                                <&zg_clk>, <&p_clk>, <&hp_clk>, <&zs_clk>,
> +                                <&zs_clk>;

For consistency, please insert the new etheravb entry between vin0 and ether,
cfr. the order in r8a7790-clock.h.

>                         #clock-cells = <1>;
>                         clock-indices = <
>                                 R8A7790_CLK_MLB R8A7790_CLK_VIN3 R8A7790_CLK_VIN2
> -                               R8A7790_CLK_VIN1 R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
> +                               R8A7790_CLK_VIN1 R8A7790_CLK_VIN0
> +                               R8A7790_CLK_ETHER R8A7790_CLK_ETHERAVB
>                                 R8A7790_CLK_SATA1 R8A7790_CLK_SATA0
>                         >;
>                         clock-output-names =
>                                 "mlb", "vin3", "vin2", "vin1", "vin0", "ether",
> -                               "sata1", "sata0";
> +                               "etheravb", "sata1", "sata0";
>                 };
>                 mstp9_clks: mstp9_clks at e6150994 {
>                         compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
> Index: renesas/include/dt-bindings/clock/r8a7790-clock.h
> ===================================================================
> --- renesas.orig/include/dt-bindings/clock/r8a7790-clock.h
> +++ renesas/include/dt-bindings/clock/r8a7790-clock.h
> @@ -105,6 +105,7 @@
>  #define R8A7790_CLK_VIN2               9
>  #define R8A7790_CLK_VIN1               10
>  #define R8A7790_CLK_VIN0               11
> +#define R8A7790_CLK_ETHERAVB           12
>  #define R8A7790_CLK_ETHER              13
>  #define R8A7790_CLK_SATA1              14
>  #define R8A7790_CLK_SATA0              15

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
