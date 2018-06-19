From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 19 Jun 2018 16:20:22 +0800
Subject: [PATCH v6 12/29] drm/mediatek: Update the definition of
 connection from RDMA1 to DPI0
In-Reply-To: <1529393670-26862-13-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
 <1529393670-26862-13-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529396422.26480.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> This patch update the definition of connection from RDMA1 to DPI0.
> Change the term MOUT to SOUT.
> 

I would like commit message describe 'why' of this patch. Both you and
me know 'why' of this patch because we have discuss previously. But for
someone who just see this patch, he or she does not understand why you
change the name. So explain 'MOUT', 'SOUT' and describe 'why' change the
naming.

Regards,
CK

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 8bfc0debd2c2..977df8facb79 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -29,7 +29,7 @@
>  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
>  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
>  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> -#define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
> +#define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
>  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
>  
>  #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
> @@ -80,7 +80,7 @@
>  #define COLOR0_SEL_IN_OVL0		0x1
>  #define OVL1_MOUT_EN_COLOR1		0x1
>  #define GAMMA_MOUT_EN_RDMA1		0x1
> -#define RDMA1_MOUT_DPI0			0x2
> +#define RDMA1_SOUT_DPI0			0x2
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define COLOR1_SEL_IN_OVL1		0x1
>  
> @@ -156,8 +156,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD1_MOUT_EN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> -		value = RDMA1_MOUT_DPI0;
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +		value = RDMA1_SOUT_DPI0;
>  	} else {
>  		value = 0;
>  	}
