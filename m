From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 12 Jun 2016 19:33:10 +0800
Subject: [PATCH 04/11] clk: imx: correct dram pll type
In-Reply-To: <1465396420-27064-4-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160612113310.GB20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:33:33PM +0800, Dong Aisheng wrote:
> From: Anson Huang <b20788@freescale.com>
> 
> DRAM PLL is a audio/video type PLL, need to correct
> it to get correct ops of PLL.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

'clk: imx7d: ' for patch prefix would be more clear.  Updated it and
applied the patch.

Shawn

> ---
>  drivers/clk/imx/clk-imx7d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 1cb866773fc0..dc8c3355a66d 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -395,7 +395,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	clks[IMX7D_PLL_VIDEO_MAIN_SRC] = imx_clk_mux("pll_video_main_src", base + 0x130, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
>  
>  	clks[IMX7D_PLL_ARM_MAIN]  = imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm_main", "pll_arm_main_src", base + 0x60, 0x7f);
> -	clks[IMX7D_PLL_DRAM_MAIN] = imx_clk_pllv3(IMX_PLLV3_SYS, "pll_dram_main", "pll_dram_main_src", base + 0x70, 0x7f);
> +	clks[IMX7D_PLL_DRAM_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_dram_main", "pll_dram_main_src", base + 0x70, 0x7f);
>  	clks[IMX7D_PLL_SYS_MAIN]  = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll_sys_main", "pll_sys_main_src", base + 0xb0, 0x1);
>  	clks[IMX7D_PLL_ENET_MAIN] = imx_clk_pllv3(IMX_PLLV3_ENET_IMX7, "pll_enet_main", "pll_enet_main_src", base + 0xe0, 0x0);
>  	clks[IMX7D_PLL_AUDIO_MAIN] = imx_clk_pllv3(IMX_PLLV3_AV, "pll_audio_main", "pll_audio_main_src", base + 0xf0, 0x7f);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
