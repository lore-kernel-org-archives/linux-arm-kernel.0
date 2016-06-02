From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 03 Jun 2016 01:02:34 +0300
Subject: [PATCH/RFC v3 16/22] clk: renesas: rcar-gen3-cpg: Remove obsolete
 rcar_gen3_read_mode_pins()
In-Reply-To: <1464808880-343-17-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-17-git-send-email-geert+renesas@glider.be>
Message-ID: <4698874.gAbrcZEWDW@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Wednesday 01 Jun 2016 21:21:14 Geert Uytterhoeven wrote:
> All R-Car Gen3 clock drivers now obtain the values of the mode pins from
> the R-Car RST driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/clk/renesas/rcar-gen3-cpg.c | 17 -----------------
>  drivers/clk/renesas/rcar-gen3-cpg.h |  1 -
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c
> b/drivers/clk/renesas/rcar-gen3-cpg.c index
> bb4f2f9a8c2f5ba8..9d76076da4948fc4 100644
> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> @@ -333,23 +333,6 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct
> device *dev, __clk_get_name(parent), 0, mult, div);
>  }
> 
> -/*
> - * Reset register definitions.
> - */
> -#define MODEMR	0xe6160060
> -
> -u32 __init rcar_gen3_read_mode_pins(void)
> -{
> -	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
> -	u32 mode;
> -
> -	BUG_ON(!modemr);
> -	mode = ioread32(modemr);
> -	iounmap(modemr);
> -
> -	return mode;
> -}
> -
>  int __init rcar_gen3_cpg_init(const struct rcar_gen3_cpg_pll_config
> *config, unsigned int clk_extalr)
>  {
> diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h
> b/drivers/clk/renesas/rcar-gen3-cpg.h index
> f699085147d1aece..f788f481dd42cdf6 100644
> --- a/drivers/clk/renesas/rcar-gen3-cpg.h
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.h
> @@ -33,7 +33,6 @@ struct rcar_gen3_cpg_pll_config {
> 
>  #define CPG_RCKCR	0x240
> 
> -u32 rcar_gen3_read_mode_pins(void);
>  struct clk *rcar_gen3_cpg_clk_register(struct device *dev,
>  	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
>  	struct clk **clks, void __iomem *base);

-- 
Regards,

Laurent Pinchart
