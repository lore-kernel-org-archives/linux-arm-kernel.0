From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 20 May 2015 09:33:46 +0900
Subject: [PATCH] drm/nouveau/platform: add IOMMU dependency
In-Reply-To: <2918377.0irYYn09PU@wuerfel>
References: <2918377.0irYYn09PU@wuerfel>
Message-ID: <555BD66A.5020704@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 09:53 PM, Arnd Bergmann wrote:
> The recently added iommu code in the nouveau driver fails to build
> when the IOMMU support is disabled:
>
> drivers/gpu/drm/nouveau/nouveau_platform.c: In function 'nouveau_platform_probe_iommu':
> drivers/gpu/drm/nouveau/nouveau_platform.c:113:41: error: 'const struct iommu_ops' has no mem
>
> To avoid the build error, this now adds an explicit dependency on the
> IOMMU implementation.

I have a local patch to nouveau_platform.c that only calls the IOMMU 
functions if CONFIG_IOMMU is set. Wouldn't this be more suitable as 
IOMMU support is only used by Tegra and thus not beneficial for desktop 
GPUs?
