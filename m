From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 15:22:28 +0800
Subject: [PATCH 23/28] drm/mediatek: add DPI1 support for mutex
In-Reply-To: <1528687580-549-24-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-24-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528874548.30263.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the DPI1 support for mutex
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 5a8569fa6505..5916fc11693a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -76,6 +76,7 @@
>  #define MUTEX_SOF_DSI0			1
>  #define MUTEX_SOF_DSI1			2
>  #define MUTEX_SOF_DPI0			3
> +#define MUTEX_SOF_DPI1			4
>  
>  #define OVL0_MOUT_EN_COLOR0		0x1
>  #define OD_MOUT_EN_RDMA0		0x1
> @@ -385,6 +386,9 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DPI0:
>  		reg = MUTEX_SOF_DPI0;
>  		break;
> +	case DDP_COMPONENT_DPI1:
> +		reg = MUTEX_SOF_DPI1;
> +		break;
>  	default:
>  		if (ddp->mutex_mod[id] < 32) {
>  			offset = DISP_REG_MUTEX_MOD(mutex->id);
> @@ -417,6 +421,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DSI0:
>  	case DDP_COMPONENT_DSI1:
>  	case DDP_COMPONENT_DPI0:
> +	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
>  			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
>  		break;
