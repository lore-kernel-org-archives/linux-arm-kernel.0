From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 03:59:42 +0800
Subject: [PATCH v2 1/2] clk: imx7d: fix USDHC NAND clock
In-Reply-To: <20170410210015.1620-1-stefan@agner.ch>
References: <20170410210015.1620-1-stefan@agner.ch>
Message-ID: <20170411195941.GA13181@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 02:00:14PM -0700, Stefan Agner wrote:
> The USDHC NAND root clock is not gated by any CCM clock gate. Remove
> the bogus gate definition.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/clk/imx/clk-imx7d.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 562055129ed8..93b03640da9b 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -724,7 +724,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider2("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6);
>  	clks[IMX7D_DISP_AXI_ROOT_DIV] = imx_clk_divider2("disp_axi_post_div", "disp_axi_pre_div", base + 0x8880, 0, 6);
>  	clks[IMX7D_ENET_AXI_ROOT_DIV] = imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0, 6);
> -	clks[IMX7D_NAND_USDHC_BUS_ROOT_DIV] = imx_clk_divider2("nand_usdhc_post_div", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
> +	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_divider2("nand_usdhc_root_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
>  	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6);
>  	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2);
>  	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div", "dram_cg", base + 0x9880, 0, 3);
> @@ -798,7 +798,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk", "enet_axi_post_div", base + 0x4060, 0);
>  	clks[IMX7D_OCRAM_CLK] = imx_clk_gate4("ocram_clk", "axi_post_div", base + 0x4110, 0);
>  	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk", "ahb_root_clk", base + 0x4120, 0);
> -	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_gate4("nand_usdhc_root_clk", "nand_usdhc_post_div", base + 0x4130, 0);
>  	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate4("dram_root_clk", "dram_post_div", base + 0x4130, 0);
>  	clks[IMX7D_DRAM_PHYM_ROOT_CLK] = imx_clk_gate4("dram_phym_root_clk", "dram_phym_cg", base + 0x4130, 0);
>  	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] = imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0);
> -- 
> 2.12.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
