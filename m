From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 05 Dec 2014 11:22:32 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1417514366.21830.22.camel@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk>
Message-ID: <54818768.3080303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-12-02 10:59, Sjoerd Simons wrote:
> Hey Marek, Inki,
>
> On Wed, 2014-11-19 at 12:15 +0100, Marek Szyprowski wrote:
>> Hello Everyone,
>>
>> This is another attempt to finally make Exynos SYSMMU driver fully
>> integrated with DMA-mapping subsystem. The main change from previous
>> version is a rebase onto latest "automatic DMA configuration for IOMMU
>> masters" patches from Will Deacon.
> Do you happen to know if anyone is working on iommu/dma-mapping patches
> for Exynos 5 based on this patchset?

I hope to add Exynos5 SYSMMU patches to the next iteration of my patchset,
but I doubt it will get into v3.19-rc1.

> For some background to that question, We (re-)discovered yesterday that
> the out-of-tree exynos-reference kernel iommu patches are required to
> get HDMI out working on exynos 5 boards. The current situation in
> mainline is rather broken, HDMI output without CONFIG_DRM_EXYNOS_IOMMU
> results in just displaying stripes[0]. While turning on
> CONFIG_DRM_EXYNOS_IOMMU causes a kernel oops at boot....

We have observed similar issues with Exynos4 based boards, when LCD0 power
domain was turned off and only TV power domain has been powered on. Please
check the power domain configuration. Maybe in case of Exynos5 the same 
issue
is caused by the interaction between DISP1 and GSCL domains.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
