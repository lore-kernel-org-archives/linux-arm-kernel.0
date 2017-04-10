From: stefan@agner.ch (Stefan Agner)
Date: Mon, 10 Apr 2017 09:51:12 -0700
Subject: [PATCH 2/2] clk: imx7d: add the missing ipg_root_clk
In-Reply-To: <1491878269-9559-2-git-send-email-aisheng.dong@nxp.com>
References: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
 <1491878269-9559-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <28a132b609dc5765d1f5f9669f525fd0@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-10 19:37, Dong Aisheng wrote:
> Add the missing ipg_root_clk which actually is already used by many
> orphan clks in current tree.

Reviewed-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index ad04483..5620551 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -386,7 +386,7 @@ static int const clks_init_on[] __initconst = {
>  	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_NAND_USDHC_BUS_ROOT_CLK,
>  	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
>  	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
> -	IMX7D_AHB_CHANNEL_ROOT_CLK,
> +	IMX7D_AHB_CHANNEL_ROOT_CLK, IMX7D_IPG_ROOT_CLK,
>  };
>  
>  static struct clk_onecell_data clk_data;
> @@ -726,6 +726,7 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_ENET_AXI_ROOT_DIV] =
> imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base +
> 0x8900, 0, 6);
>  	clks[IMX7D_NAND_USDHC_BUS_ROOT_DIV] =
> imx_clk_divider2("nand_usdhc_post_div", "nand_usdhc_pre_div", base +
> 0x8980, 0, 6);
>  	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk",
> "ahb_pre_div", base + 0x9000, 0, 6);
> +	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk",
> "ahb_root_clk", base + 0x9080, 0, 2);
>  	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div",
> "dram_cg", base + 0x9880, 0, 3);
>  	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] =
> imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div",
> base + 0xa000, 0, 3);
>  	clks[IMX7D_DRAM_ALT_ROOT_DIV] =
> imx_clk_divider2("dram_alt_post_div", "dram_alt_pre_div", base +
> 0xa080, 0, 3);
