From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Thu, 6 Oct 2016 15:09:31 +0200
Subject: [PATCH] exynos-drm: Fix error messages to print flags and size
In-Reply-To: <1470850236-9101-1-git-send-email-shuahkh@osg.samsung.com>
References: <1470850236-9101-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <57F64D0B.5050506@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I think this patch was never picked up. So just a short 'ping' from my side.

With best wishes,
Tobias


Shuah Khan wrote:
> Fix exynos_drm_gem_create() error messages to include flags and size when
> flags and size are invalid.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index cdf9f1a..4c4cb0e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -231,12 +231,12 @@ struct exynos_drm_gem *exynos_drm_gem_create(struct drm_device *dev,
>  	int ret;
>  
>  	if (flags & ~(EXYNOS_BO_MASK)) {
> -		DRM_ERROR("invalid flags.\n");
> +		DRM_ERROR("invalid GEM buffer flags: %u\n", flags);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	if (!size) {
> -		DRM_ERROR("invalid size.\n");
> +		DRM_ERROR("invalid GEM buffer size: %lu\n", size);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> 
