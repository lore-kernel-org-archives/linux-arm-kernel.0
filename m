From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 28 May 2018 15:13:29 +0800
Subject: [PATCH v4 7/9] drm/mediatek: add connection from OD1 to RDMA1
In-Reply-To: <1527489507-24453-8-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
 <1527489507-24453-8-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527491609.24367.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch add the connection from OD1 to RDMA1 for ext path.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 58e44349e315..8bfc0debd2c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -75,6 +75,7 @@
>  
>  #define OVL0_MOUT_EN_COLOR0		0x1
>  #define OD_MOUT_EN_RDMA0		0x1
> +#define OD1_MOUT_EN_RDMA1		BIT(16)
>  #define UFOE_MOUT_EN_DSI0		0x1
>  #define COLOR0_SEL_IN_OVL0		0x1
>  #define OVL1_MOUT_EN_COLOR1		0x1
> @@ -151,6 +152,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
>  		*addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
>  		value = GAMMA_MOUT_EN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
> +		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> +		value = OD1_MOUT_EN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
