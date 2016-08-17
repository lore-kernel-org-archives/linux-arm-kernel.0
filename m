From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 17 Aug 2016 15:47:03 +0200
Subject: [PATCH/RTF 2/7] clk: renesas: r8a7796: Add SDIF clocks
In-Reply-To: <1471433516-4478-3-git-send-email-horms+renesas@verge.net.au>
References: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
 <1471433516-4478-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWzCK9Btmbmd0ZHzC5TE-rc=c6QhcPB9Za9BzBaNvdoUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Aug 17, 2016 at 1:31 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>
>
> This patch adds SDIF clocks for R8A7796 SoC.
>
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/clk/renesas/r8a7796-cpg-mssr.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> index 999955c2b23e..4c390a8bc3e1 100644
> --- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> @@ -93,6 +93,11 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
>         DEF_FIXED("s3d2",       R8A7796_CLK_S3D2,  CLK_S3,         2, 1),
>         DEF_FIXED("s3d4",       R8A7796_CLK_S3D4,  CLK_S3,         4, 1),
>
> +       DEF_GEN3_SD("sd0",      R8A7796_CLK_SD0,   CLK_PLL1_DIV4, 0x0074),
> +       DEF_GEN3_SD("sd1",      R8A7796_CLK_SD1,   CLK_PLL1_DIV4, 0x0078),
> +       DEF_GEN3_SD("sd2",      R8A7796_CLK_SD2,   CLK_PLL1_DIV4, 0x0268),
> +       DEF_GEN3_SD("sd3",      R8A7796_CLK_SD3,   CLK_PLL1_DIV4, 0x026c),

While the definitions above give the right frequencies, they don't describe
the correct topology. Please introduce an intermediate "SDSRC" clock, cfr.
"clk: renesas: r8a7795: Fix SD clocks" for R-Car H3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
