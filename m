From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 10 Aug 2016 13:37:53 -0400
Subject: [PATCH v2] exynos-drm: Fix unsupported GEM memory type error
 message to be clear
In-Reply-To: <1470700100-13306-1-git-send-email-shuahkh@osg.samsung.com>
References: <1470700100-13306-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <a111b98f-0596-79bf-77e2-be9a95875369@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On 08/08/2016 07:48 PM, Shuah Khan wrote:
> Fix unsupported GEM memory type error message to include the memory type
> information.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> Changes since v1:
> -- Comment changed to read clearly
> 
>  drivers/gpu/drm/exynos/exynos_drm_fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> index e016640..40ce841 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> @@ -55,11 +55,11 @@ static int check_fb_gem_memory_type(struct drm_device *drm_dev,
>  	flags = exynos_gem->flags;
>  
>  	/*
> -	 * without iommu support, not support physically non-continuous memory
> -	 * for framebuffer.
> +	 * Physically non-contiguous memory type for framebuffer is not
> +	 * supported without IOMMU.
>  	 */
>  	if (IS_NONCONTIG_BUFFER(flags)) {
> -		DRM_ERROR("cannot use this gem memory type for fb.\n");
> +		DRM_ERROR("Non-contiguous GEM memory is not supported.\n");
>  		return -EINVAL;
>  	}
>  
> 

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
