From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 18:07:38 +0800
Subject: [PATCH v2 17/26] drm/rockchip: dw-mipi-dsi: don't enable PHY PLL
 until it's configured
In-Reply-To: <20170121163128.22240-18-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-18-john@metanate.com>
Message-ID: <5884846A.7040200@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

This patch do the similar thing with 
https://patchwork.kernel.org/patch/9530405/
They are changing the phy configuration order, my suggestion is to merge 
them.


On 01/22/2017 12:31 AM, John Keeping wrote:
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index ce1e6f9a2041..cfe7e4ba305c 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -413,12 +413,12 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
>   
>   	dw_mipi_dsi_phy_write(dsi, 0x44, HSFREQRANGE_SEL(testdin));
>   
> -	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
>   	dw_mipi_dsi_phy_write(dsi, 0x17, INPUT_DIVIDER(dsi->input_div));
>   	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_LOW_SEL(dsi->feedback_div) |
>   					 LOW_PROGRAM_EN);
>   	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
>   					 HIGH_PROGRAM_EN);
> +	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
>   
>   	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
>   					 BIASEXTR_SEL(BIASEXTR_127_7));
