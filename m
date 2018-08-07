From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 7 Aug 2018 11:47:49 +0800
Subject: [PATCH v3 10/13] drm/mediatek: add callback function to return
 RDMA layer number
In-Reply-To: <1533556700-26525-11-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
 <1533556700-26525-11-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533613669.22668.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-08-06 at 19:58 +0800, Stu Hsieh wrote:
> This patch add callback function to return RDMA layer number
> 
> RDMA always has one layer.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

I would like to remove the term 'callback' because this is just function
pointer rather than callback function. OVL does not register callback
function to crtc and crtc call OVL function directly. The modification
is good to me, so

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 91a8b6e27d39..68c99253285b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -188,6 +188,11 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
>  	}
>  }
>  
> +static unsigned int mtk_rdma_layer_nr(struct mtk_ddp_comp *comp)
> +{
> +	return 1;
> +}
> +
>  static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  				  struct mtk_plane_state *state)
>  {
> @@ -220,6 +225,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
>  	.stop = mtk_rdma_stop,
>  	.enable_vblank = mtk_rdma_enable_vblank,
>  	.disable_vblank = mtk_rdma_disable_vblank,
> +	.layer_nr = mtk_rdma_layer_nr,
>  	.layer_config = mtk_rdma_layer_config,
>  };
>  
