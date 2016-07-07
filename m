From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 7 Jul 2016 22:18:02 +0900
Subject: next-20160707 build: 1 failures 6 warnings (next-20160707)
In-Reply-To: <20160707122219.GO6247@sirena.org.uk>
References: <E1bL5XI-0004Z9-EP@optimist> <20160707122219.GO6247@sirena.org.uk>
Message-ID: <CAAFQd5DacKar+T1Fj62NvAZOT_QWBhahftZJXGq40Z19n-Z4Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jul 7, 2016 at 9:22 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 07, 2016 at 10:23:56AM +0100, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 allmodconfig due to:
>
>>       arm64-allmodconfig
>> ../drivers/gpu/drm/rockchip/rockchip_drm_drv.c:17:27: fatal error: asm/dma-iommu.h: No such file or directory
>
> triggered by c51f43a9c171ea (iommu/rockchip: Enable Rockchip IOMMU on
> ARM64) which enables the Rockchip IOMMU driver on ARM64 which lacks the
> above header.  Either the use of the header needs to be removed or an
> explicit ARM64 dependency added at the DRM level.

Looks like next is missing the DRM side of the series, which makes the
driver in question not need this header anymore.

This is probably because we missed this hidden dependency and decided
to push the IOMMU part separately through the IOMMU tree. I guess we
can remove the offending patch from the IOMMU tree and let the DRM
tree include it based on a topic branch from Joerg.

Joerg, David, Mark Yao, what do you think?

Best regards,
Tomasz
