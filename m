From: treding@nvidia.com (Thierry Reding)
Date: Tue, 19 May 2015 15:32:27 +0200
Subject: [PATCH] drm/nouveau/platform: add IOMMU dependency
In-Reply-To: <2918377.0irYYn09PU@wuerfel>
References: <2918377.0irYYn09PU@wuerfel>
Message-ID: <20150519133225.GA26555@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 02:53:26PM +0200, Arnd Bergmann wrote:
> The recently added iommu code in the nouveau driver fails to build
> when the IOMMU support is disabled:
> 
> drivers/gpu/drm/nouveau/nouveau_platform.c: In function 'nouveau_platform_probe_iommu':
> drivers/gpu/drm/nouveau/nouveau_platform.c:113:41: error: 'const struct iommu_ops' has no mem
> 
> To avoid the build error, this now adds an explicit dependency on the
> IOMMU implementation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 58fd9375c2c5 ("drm/nouveau/platform: probe IOMMU if present")

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/b896fe1c/attachment.sig>
