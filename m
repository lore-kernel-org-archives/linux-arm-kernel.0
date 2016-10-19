From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 19 Oct 2016 15:12:39 +0800
Subject: [PATCH 2/2] iommu/mediatek: Convert M4Uv1 to iommu_fwspec
In-Reply-To: <a40dbcc1ff40bf09483316354d2fdcb2d432eb81.1476704508.git.robin.murphy@arm.com>
References: <0205bf6404b16bdebe8039bfc65570a2a6f9f960.1476704508.git.robin.murphy@arm.com>
 <a40dbcc1ff40bf09483316354d2fdcb2d432eb81.1476704508.git.robin.murphy@arm.com>
Message-ID: <1476861159.31964.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-17 at 12:49 +0100, Robin Murphy wrote:
> Our per-device data consists of the M4U instance and firmware-provided
> list of LARB IDs, which is a perfect fit for the generic iommu_fwspec
> machinery. Use that directly instead of the custom archdata code - while
> we can't rely on the of_xlate() mechanism to initialise things until the
> 32-bit ARM DMA code learns about groups and default domains, it still
> results in a reasonable simplification overall.
> 
> CC: Honghui Zhang <honghui.zhang@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks Robin.
Tested-by: Honghui Zhang <honghui.zhang@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.h    |  6 ---
>  drivers/iommu/mtk_iommu_v1.c | 95 +++++++++++++++++---------------------------
>  2 files changed, 36 insertions(+), 65 deletions(-)
> 
