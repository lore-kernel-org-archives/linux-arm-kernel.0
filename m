From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 13:38:03 +0800
Subject: [PATCH 11/28] drm/mediatek: add connection from RDMA0 to DPI0
In-Reply-To: <1528687580-549-12-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-12-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528868283.15127.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA0 to DPI0
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 8bfc0debd2c2..d7953f2f6a36 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -29,6 +29,7 @@
>  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
>  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
>  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> +#define DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN	0x0c4
>  #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
>  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
>  
> @@ -80,6 +81,7 @@
>  #define COLOR0_SEL_IN_OVL0		0x1
>  #define OVL1_MOUT_EN_COLOR1		0x1
>  #define GAMMA_MOUT_EN_RDMA1		0x1
> +#define RDMA0_MOUT_DPI0			0x2
>  #define RDMA1_MOUT_DPI0			0x2
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define COLOR1_SEL_IN_OVL1		0x1
> @@ -155,6 +157,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD1_MOUT_EN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> +		value = RDMA0_MOUT_DPI0;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
