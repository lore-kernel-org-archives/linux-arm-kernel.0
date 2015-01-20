From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 15:54:05 +0800
Subject: [PATCH] ARM: clk-imx6q: refine esai_ipg's parent
In-Reply-To: <1421377024-29699-1-git-send-email-shengjiu.wang@freescale.com>
References: <1421377024-29699-1-git-send-email-shengjiu.wang@freescale.com>
Message-ID: <20150120075404.GV2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:57:04AM +0800, Shengjiu Wang wrote:
> esai_ipg clock's parent is ahb, not ipg.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Applied, thanks.

> ---
>  arch/arm/mach-imx/clk-imx6q.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 2daef61..d04a430 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -386,7 +386,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
>  	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
>  	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
> -	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ipg",           base + 0x6c, 16, &share_count_esai);
> +	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
>  	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
>  	clk[IMX6QDL_CLK_GPT_IPG]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
>  	clk[IMX6QDL_CLK_GPT_IPG_PER]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
> -- 
> 1.7.9.5
> 
