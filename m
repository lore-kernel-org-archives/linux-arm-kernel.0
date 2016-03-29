From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Tue, 29 Mar 2016 10:46:11 +0900
Subject: [PATCH 0/3] drm/exynos: Kconfig dependency fixes
In-Reply-To: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
References: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
Message-ID: <56F9DE63.6050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 2016? 03? 29? 10:28, Javier Martinez Canillas wrote:
> Hello Inki,
> 
> This patch series contains some fixes for the Kconfig symbol dependencies
> of the Exynos DRM driver. They make sure that the Exynos DRM components
> and the media platform drivers that makes use of the same HW IP block are
> not enabled at the same time.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (3):
>   drm/exynos: Use VIDEO_SAMSUNG_S5P_G2D=n as G2D Kconfig dependency
>   drm/exynos: Use VIDEO_SAMSUNG_EXYNOS_GSC=n as GSC Kconfig dependency
>   drm/exynos: Make DRM_EXYNOS_FIMC depend on VIDEO_S5P_FIMC=n

In G2D case, there is only one instance, but for the other cases, there
are several instances and in my environment, I enable both drivers on
v4l2 and drm FIMC/GSC.

So, IMHO, the not-enabled v4l2 dependency is not really required for drm
fimc and drm gsc.

Best Regards,
- Seung-Woo Kim

> 
>  drivers/gpu/drm/exynos/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

-- 
Seung-Woo Kim
Samsung Software R&D Center
--
