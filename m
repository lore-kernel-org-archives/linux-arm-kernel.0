From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Jun 2017 11:04:20 +0200
Subject: [PATCH] drm/mediatek: check for memory allocation failure
In-Reply-To: <20170609192712.18155-1-christophe.jaillet@wanadoo.fr>
References: <20170609192712.18155-1-christophe.jaillet@wanadoo.fr>
Message-ID: <dd470cb8-8f72-81c1-b323-adcd952856f0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/06/17 21:27, Christophe JAILLET wrote:
> If 'devm_kmalloc_array' returns NULL, we should return -ENOMEM as already
> done a few lines above instead of deferencing a NULL pointer a few lines
> below.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 6582e1f56d37..cb32c9369f3a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -559,6 +559,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>   	mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
>   						sizeof(*mtk_crtc->ddp_comp),
>   						GFP_KERNEL);
> +	if (!mtk_crtc->ddp_comp)
> +		return -ENOMEM;
>   
>   	mtk_crtc->mutex = mtk_disp_mutex_get(priv->mutex_dev, pipe);
>   	if (IS_ERR(mtk_crtc->mutex)) {
> 
