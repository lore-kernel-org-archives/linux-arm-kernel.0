From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jul 2016 14:22:19 +0200
Subject: next-20160707 build: 1 failures 6 warnings (next-20160707)
In-Reply-To: <E1bL5XI-0004Z9-EP@optimist>
References: <E1bL5XI-0004Z9-EP@optimist>
Message-ID: <20160707122219.GO6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 10:23:56AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../drivers/gpu/drm/rockchip/rockchip_drm_drv.c:17:27: fatal error: asm/dma-iommu.h: No such file or directory

triggered by c51f43a9c171ea (iommu/rockchip: Enable Rockchip IOMMU on
ARM64) which enables the Rockchip IOMMU driver on ARM64 which lacks the
above header.  Either the use of the header needs to be removed or an
explicit ARM64 dependency added at the DRM level.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/bbf16e3b/attachment.sig>
