From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 9 Aug 2018 10:37:42 +0800
Subject: [PATCH v4 07/14] drm/mediatek: add the comment about color
 format setting for OVL
In-Reply-To: <1533780949-30141-8-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
 <1533780949-30141-8-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533782262.29986.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Thu, 2018-08-09 at 10:15 +0800, Stu Hsieh wrote:
> This patch add the comment about color format setting for OVL
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 978782a77629..0facd823c552 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -157,6 +157,11 @@ static void mtk_ovl_layer_off(struct mtk_ddp_comp *comp, unsigned int idx)
>  
>  static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
>  {
> +	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
> +	 * is defined in mediatek HW data sheet.
> +	 * The alphabet order in XXX is no relation to data
> +	 * arrangement in memory.
> +	 */
>  	switch (fmt) {
>  	default:
>  	case DRM_FORMAT_RGB565:
