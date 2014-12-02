From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 02 Dec 2014 10:59:26 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1417514366.21830.22.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Marek, Inki,

On Wed, 2014-11-19 at 12:15 +0100, Marek Szyprowski wrote:
> Hello Everyone,
> 
> This is another attempt to finally make Exynos SYSMMU driver fully
> integrated with DMA-mapping subsystem. The main change from previous
> version is a rebase onto latest "automatic DMA configuration for IOMMU
> masters" patches from Will Deacon.

Do you happen to know if anyone is working on iommu/dma-mapping patches
for Exynos 5 based on this patchset? 

For some background to that question, We (re-)discovered yesterday that
the out-of-tree exynos-reference kernel iommu patches are required to
get HDMI out working on exynos 5 boards. The current situation in
mainline is rather broken, HDMI output without CONFIG_DRM_EXYNOS_IOMMU
results in just displaying stripes[0]. While turning on
CONFIG_DRM_EXYNOS_IOMMU causes a kernel oops at boot....


0: http://people.collabora.com/~sjoerd/14120001.jpg

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/a29ad0cc/attachment-0001.bin>
