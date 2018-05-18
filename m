From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 May 2018 15:03:48 +0200
Subject: [PATCH V2 1/3] clk: imx7d: correct enet phy ref clock gates
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <66f3e8827e41338291c3e2298cbc87cc@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.05.2018 03:01, Anson Huang wrote:
> IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY directly,
> there is no clock gate after it, rename it to
> IMX7D_ENET_PHY_REF_ROOT_CLK to avoid device tree change.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  drivers/clk/imx/clk-imx7d.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 975a20d..23d5090a 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -738,7 +738,7 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_ENET1_TIME_ROOT_DIV] =
> imx_clk_divider2("enet1_time_post_div", "enet1_time_pre_div", base +
> 0xa780, 0, 6);
>  	clks[IMX7D_ENET2_REF_ROOT_DIV] =
> imx_clk_divider2("enet2_ref_post_div", "enet2_ref_pre_div", base +
> 0xa800, 0, 6);
>  	clks[IMX7D_ENET2_TIME_ROOT_DIV] =
> imx_clk_divider2("enet2_time_post_div", "enet2_time_pre_div", base +
> 0xa880, 0, 6);
> -	clks[IMX7D_ENET_PHY_REF_ROOT_DIV] =
> imx_clk_divider2("enet_phy_ref_post_div", "enet_phy_ref_pre_div", base
> + 0xa900, 0, 6);
> +	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_divider2("enet_phy_ref_root_clk", "enet_phy_ref_pre_div", base
> + 0xa900, 0, 6);
>  	clks[IMX7D_EIM_ROOT_DIV] = imx_clk_divider2("eim_post_div",
> "eim_pre_div", base + 0xa980, 0, 6);
>  	clks[IMX7D_NAND_ROOT_CLK] = imx_clk_divider2("nand_root_clk",
> "nand_pre_div", base + 0xaa00, 0, 6);
>  	clks[IMX7D_QSPI_ROOT_DIV] = imx_clk_divider2("qspi_post_div",
> "qspi_pre_div", base + 0xaa80, 0, 6);
> @@ -816,7 +816,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base +
> 0x44f0, 0);
>  	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk",
> "enet2_ref_post_div", base + 0x4500, 0);
>  	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base +
> 0x4510, 0);
> -	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base +
> 0x4520, 0);
>  	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
> "eim_post_div", base + 0x4160, 0);
>  	clks[IMX7D_NAND_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base +
> 0x4140, 0, &share_count_nand);
>  	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk",
> base + 0x4140, 0, &share_count_nand);
