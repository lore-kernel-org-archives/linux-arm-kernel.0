From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 14 Apr 2017 14:49:19 +0200
Subject: [PATCH v7 1/9] drm/cma: Update DEFINE_DRM_GEM_CMA_FOPS to add
 get_unmapped_area
In-Reply-To: <1492164819-10513-2-git-send-email-yannick.fertre@st.com>
References: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
 <1492164819-10513-2-git-send-email-yannick.fertre@st.com>
Message-ID: <f9c28c29-a681-0157-a6a8-e7cf244d8775@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2017 12:13 PM, Yannick Fertre wrote:
> Missing field get_unmapped_area which is necessary with device without MMU
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  include/drm/drm_gem_cma_helper.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
> index f962d33..7320b14 100644
> --- a/include/drm/drm_gem_cma_helper.h
> +++ b/include/drm/drm_gem_cma_helper.h
> @@ -50,6 +50,7 @@ struct drm_gem_cma_object {
>  		.read		= drm_read,\
>  		.llseek		= noop_llseek,\
>  		.mmap		= drm_gem_cma_mmap,\
> +		.get_unmapped_area	= drm_gem_cma_get_unmapped_area,\
>  	}
>  
>  /* free GEM object */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
