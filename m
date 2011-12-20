From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 20 Dec 2011 14:49:37 +0100
Subject: [PATCH 10/12] ASoC: mxs-saif: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-11-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <201112201449.37879.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The patch converts mxs-saif driver to clk_prepare/clk_unprepare by
> using helper functions clk_prepare_enable/clk_disable_unprepare.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Dong Aisheng <b29396@freescale.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/mxs/mxs-saif.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index 76dc74d..ef1abb5 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -210,7 +210,7 @@ int mxs_saif_put_mclk(unsigned int saif_id)
>  		return -EBUSY;
>  	}
> 
> -	clk_disable(saif->clk);
> +	clk_disable_unprepare(saif->clk);
> 
>  	/* disable MCLK output */
>  	__raw_writel(BM_SAIF_CTRL_CLKGATE,
> @@ -264,7 +264,7 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned
> int mclk, if (ret)
>  		return ret;
> 
> -	ret = clk_enable(saif->clk);
> +	ret = clk_prepare_enable(saif->clk);
>  	if (ret)
>  		return ret;

Acked-by: Marek Vasut <marek.vasut@gmail.com>
