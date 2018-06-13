From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 15:07:38 +0800
Subject: [PATCH 18/28] drm/mediatek: add connection from RDMA2 to DPI0
In-Reply-To: <1528687580-549-19-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-19-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528873658.30263.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA2 to DPI0
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index a5cee4b7f908..31a0832ef9ec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -31,6 +31,7 @@
>  #define DISP_REG_CONFIG_DSIE_SEL_IN		0x0a4
>  #define DISP_REG_CONFIG_DSIO_SEL_IN		0x0a8
>  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> +#define DISP_REG_CONFIG_DISP_RDMA2_SOUT		0x0b8
>  #define DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN	0x0c4
>  #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
>  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
> @@ -91,7 +92,9 @@
>  #define RDMA1_MOUT_DSI3			0x5
>  #define RDMA1_MOUT_DPI0			0x2
>  #define RDMA1_MOUT_DPI1			0x3
> +#define RDMA2_MOUT_DPI0			0x2
>  #define DPI0_SEL_IN_RDMA1		0x1
> +#define DPI0_SEL_IN_RDMA2		0x3
>  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
>  #define DSI1_SEL_IN_RDMA1		0x1
>  #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
> @@ -193,6 +196,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI1;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +		value = RDMA2_MOUT_DPI0;
>  	} else {
>  		value = 0;
>  	}
> @@ -224,6 +230,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
>  		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>  		value = DSI3_SEL_IN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> +		value = DPI0_SEL_IN_RDMA2;
>  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
>  		value = COLOR1_SEL_IN_OVL1;
