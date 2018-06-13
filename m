From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 13:39:50 +0800
Subject: [PATCH 12/28] drm/mediatek: add connection from RDMA0 to DSI2
In-Reply-To: <1528687580-549-13-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-13-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528868390.15127.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA0 to DSI2
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index d7953f2f6a36..c08aed8dae44 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -82,6 +82,7 @@
>  #define OVL1_MOUT_EN_COLOR1		0x1
>  #define GAMMA_MOUT_EN_RDMA1		0x1
>  #define RDMA0_MOUT_DPI0			0x2
> +#define RDMA0_MOUT_DSI2			0x4
>  #define RDMA1_MOUT_DPI0			0x2
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define COLOR1_SEL_IN_OVL1		0x1
> @@ -160,6 +161,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
>  		value = RDMA0_MOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> +		value = RDMA0_MOUT_DSI2;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
