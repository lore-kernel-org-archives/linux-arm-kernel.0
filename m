From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 14:13:30 +0800
Subject: [PATCH 14/28] drm/mediatek: add connection from RDMA1 to DPI1
In-Reply-To: <1528687580-549-15-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-15-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528870410.15127.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA1 to DPI1
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index fed1b5704355..4abd5dabeccf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -85,7 +85,9 @@
>  #define RDMA0_MOUT_DSI2			0x4
>  #define RDMA0_MOUT_DSI3			0x5
>  #define RDMA1_MOUT_DPI0			0x2
> +#define RDMA1_MOUT_DPI1			0x3

Usually, each bit of a mout register represent a output enable. Is this
value 0x3 a correct value?

Regards,
CK

>  #define DPI0_SEL_IN_RDMA1		0x1
> +#define DPI1_SEL_IN_RDMA1		(0x1 << 8)
>  #define COLOR1_SEL_IN_OVL1		0x1
>  
>  #define OVL_MOUT_EN_RDMA		0x1
> @@ -171,6 +173,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> +		value = RDMA1_MOUT_DPI1;
>  	} else {
>  		value = 0;
>  	}
> @@ -190,6 +195,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
>  		value = DPI0_SEL_IN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> +		value = DPI1_SEL_IN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
>  		value = COLOR1_SEL_IN_OVL1;
