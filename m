From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Aug 2015 12:59:56 +0200
Subject: [PATCH] soc: mediatek: add scpsys support active_wakeup
In-Reply-To: <1437631249-706-1-git-send-email-eddie.huang@mediatek.com>
References: <1437631249-706-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150824105956.GT5161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 02:00:49PM +0800, Eddie Huang wrote:
> Register gpd_dev_ops.active_wakeup function to support keep power
> during suspend state. And add flag to each power domain to
> decide whether keep power during suspend or not.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 43a79ed..fc78b70 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -67,6 +67,7 @@ struct scp_domain_data {
>  	u32 sram_pdn_ack_bits;
>  	u32 bus_prot_mask;
>  	enum clk_id clk_id;
> +	bool active_wakeup;
>  };
>  
>  static const struct scp_domain_data scp_domain_data[] __initconst = {
> @@ -77,6 +78,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  		.clk_id = MT8173_CLK_MM,
> +		.active_wakeup = false,

You can drop the .active_wakeup = false lines.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
