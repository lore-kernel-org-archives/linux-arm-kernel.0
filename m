From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Mar 2016 11:17:48 +0100
Subject: [PATCH 03/13] ARM: dts: sh73a0: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-4-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
 <1458610840-15194-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWPocvJj8_YfGNUyPnEajEK0uMLv_rj-NVUsWRdAZgWcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 2:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Fixed rate and fixed factor clocks do not require an
>   clock-output-names property.
> * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
>   optional") Renesas div6 clocks do not require a clock-output-names
>   property.
>
> In the above cases there is only one clock output and its name is taken
> from that of the clock node.
>
> Accordingly, remove the unnecessary clock-output-names properties and as
> necessary update the node names. The zb_clk is excluded from this rename
> as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
> named zb_clk for the r8a73a4 and sh73a0 SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/sh73a0.dtsi | 88 ++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 59 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index bf825ca4f6f7..e697250886ef 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi

> @@ -686,170 +677,149 @@
>                         clocks = <&pll1_div2_clk>, <0>,
>                                  <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
>                         #clock-cells = <0>;
> -                       clock-output-names = "zb";
>                 };

Same comment here as for r8a73a4:

I'm wondering whether we should keep this one for now?
Dropping it changes the clock name from "zb_clk" to "zb".



-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
