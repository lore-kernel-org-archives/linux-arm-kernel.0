From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 15:04:43 +0800
Subject: [PATCH 17/28] drm/mediatek: add connection from RDMA1 to DSI3
In-Reply-To: <1528687580-549-18-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-18-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528873483.30263.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA1 to DSI3
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index c3e647b04ffd..a5cee4b7f908 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -88,12 +88,14 @@
>  #define RDMA0_MOUT_DSI3			0x5
>  #define RDMA1_MOUT_DSI1			0x1
>  #define RDMA1_MOUT_DSI2			0x4
> +#define RDMA1_MOUT_DSI3			0x5

Usually, each bit of a mout register represent a output enable. Is this
value 0x5 a correct value?

Regards,
CK

>  #define RDMA1_MOUT_DPI0			0x2
>  #define RDMA1_MOUT_DPI1			0x3
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
>  #define DSI1_SEL_IN_RDMA1		0x1
>  #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
> +#define DSI3_SEL_IN_RDMA1		(0x1 << 16)
>  #define COLOR1_SEL_IN_OVL1		0x1
>  
>  #define OVL_MOUT_EN_RDMA		0x1
> @@ -182,6 +184,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DSI2;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> +		value = RDMA1_MOUT_DSI3;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
> @@ -216,6 +221,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
>  		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>  		value = DSI2_SEL_IN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
> +		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
> +		value = DSI3_SEL_IN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
>  		value = COLOR1_SEL_IN_OVL1;
