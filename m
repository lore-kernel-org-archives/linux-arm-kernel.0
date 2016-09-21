From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 21 Sep 2016 11:29:48 +0800
Subject: [PATCH] clk: mediatek: clk-mt8173: Unmap region obtained by
 of_iomap
In-Reply-To: <1474360242-15126-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474360242-15126-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1474428588.10249.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-09-20 at 14:00 +0530, Arvind Yadav wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Free memory mapping, if init is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: James Liao <jamesjj.liao@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mt8173.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 10c9860..0ac3aee 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -1074,8 +1074,10 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
>  	}
>  
>  	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> -	if (!clk_data)
> +	if (!clk_data) {
> +		iounmap(base);
>  		return;
> +	}
>  
>  	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>  
