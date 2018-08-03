From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 3 Aug 2018 12:57:52 +0800
Subject: [PATCH v2 01/15] drm/mediatek: add connection from RDMA0 to DPI1
In-Reply-To: <1533265868-28110-2-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
 <1533265868-28110-2-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533272272.31144.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Fri, 2018-08-03 at 11:10 +0800, Stu Hsieh wrote:
> This patch add connection from RDMA0 to DPI1
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 87e4191c250e..03e3628b5b0d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -106,6 +106,7 @@
>  #define OVL1_MOUT_EN_COLOR1		0x1
>  #define GAMMA_MOUT_EN_RDMA1		0x1
>  #define RDMA0_SOUT_DPI0			0x2
> +#define RDMA0_SOUT_DPI1			0x3
>  #define RDMA0_SOUT_DSI2			0x4
>  #define RDMA0_SOUT_DSI3			0x5
>  #define RDMA1_SOUT_DPI0			0x2
> @@ -224,6 +225,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>  		value = RDMA0_SOUT_DPI0;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DPI1;
>  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>  		value = RDMA0_SOUT_DSI2;
