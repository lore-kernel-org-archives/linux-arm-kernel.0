From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jun 2012 09:46:21 +0200
Subject: [PATCH] clk: mxs: fix ref_io clock definition
In-Reply-To: <1340331709-15188-1-git-send-email-shawn.guo@linaro.org>
References: <1340331709-15188-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FEABA4D.7000004@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 22/06/2012 04:21, Shawn Guo a ?crit :
> The definition of clocks ref_io0 and ref_io1 were inverted.  It causes
> a mmc regression on some boards right away.  Fix the regression by
> correcting the ref_io clock definition.
> 
> Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

> ---
>  drivers/clk/mxs/clk-imx28.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 2826a26..17e85a1 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -245,8 +245,8 @@ int __init mx28_clocks_init(void)
>  	clks[pll2] = mxs_clk_pll("pll2", "ref_xtal", PLL2CTRL0, 23, 50000000);
>  	clks[ref_cpu] = mxs_clk_ref("ref_cpu", "pll0", FRAC0, 0);
>  	clks[ref_emi] = mxs_clk_ref("ref_emi", "pll0", FRAC0, 1);
> -	clks[ref_io0] = mxs_clk_ref("ref_io0", "pll0", FRAC0, 2);
> -	clks[ref_io1] = mxs_clk_ref("ref_io1", "pll0", FRAC0, 3);
> +	clks[ref_io1] = mxs_clk_ref("ref_io1", "pll0", FRAC0, 2);
> +	clks[ref_io0] = mxs_clk_ref("ref_io0", "pll0", FRAC0, 3);
>  	clks[ref_pix] = mxs_clk_ref("ref_pix", "pll0", FRAC1, 0);
>  	clks[ref_hsadc] = mxs_clk_ref("ref_hsadc", "pll0", FRAC1, 1);
>  	clks[ref_gpmi] = mxs_clk_ref("ref_gpmi", "pll0", FRAC1, 2);


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
