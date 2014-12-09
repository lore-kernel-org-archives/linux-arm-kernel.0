From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 9 Dec 2014 09:59:12 +0100
Subject: [PATCH] ARM: shmobile: r8a7791: Add IPMMU-SGX clock to device tree
In-Reply-To: <1418098882-5317-1-git-send-email-horms+renesas@verge.net.au>
References: <1418098882-5317-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW7htFTeaPaL+yJ3giW0oFLch_D7W9wVw7bJR95+3b_4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 9, 2014 at 5:21 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [horms: resolved conflicts]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looks OK to me...

> ---
>
> Based on the renesas-devel-20141209-v3.18 tag of my renesas tree
>
> * Update by Simon Horman
>   - Use SGX rather than GP in clock name to reflect datasheet
> ---
>  arch/arm/boot/dts/r8a7791.dtsi            | 8 +++++---
>  include/dt-bindings/clock/r8a7791-clock.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 958a69b..78d6371 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1154,15 +1154,17 @@
>                 mstp8_clks: mstp8_clks at e6150990 {
>                         compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>                         reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -                       clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>, <&zs_clk>,
> -                                <&zs_clk>;
> +                       clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
> +                                <&zs_clk>, <&zs_clk>;

... but I couldn't find the parent clock in the documentation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
