From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 15:22:58 +0800
Subject: [PATCH 25/28] drm/mediatek: add DSI3 support for mutex
In-Reply-To: <1528687580-549-26-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-26-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528874578.30263.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the DSI3 support for mutex
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 1e7e3872eccc..28dd8531a7de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -78,6 +78,7 @@
>  #define MUTEX_SOF_DPI0			3
>  #define MUTEX_SOF_DPI1			4
>  #define MUTEX_SOF_DSI2			5
> +#define MUTEX_SOF_DSI3			6
>  
>  #define OVL0_MOUT_EN_COLOR0		0x1
>  #define OD_MOUT_EN_RDMA0		0x1
> @@ -387,6 +388,9 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DSI2:
>  		reg = MUTEX_SOF_DSI2;
>  		break;
> +	case DDP_COMPONENT_DSI3:
> +		reg = MUTEX_SOF_DSI3;
> +		break;
>  	case DDP_COMPONENT_DPI0:
>  		reg = MUTEX_SOF_DPI0;
>  		break;
> @@ -425,6 +429,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DSI0:
>  	case DDP_COMPONENT_DSI1:
>  	case DDP_COMPONENT_DSI2:
> +	case DDP_COMPONENT_DSI3:
>  	case DDP_COMPONENT_DPI0:
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
