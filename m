From: jgutierrez@ti.com (Gutierrez, Juan)
Date: Fri, 13 Apr 2012 16:53:23 -0500
Subject: [PATCH 2/3] OMAP4: iommu: fix irq and clock name for dsp-iommu
In-Reply-To: <1334352255-48584-3-git-send-email-jgutierrez@ti.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
 <1334352255-48584-3-git-send-email-jgutierrez@ti.com>
Message-ID: <CADVn9RE+n++eUmrZTMtdDbupWjpYmRxT=YemGikaCxonJ1yJ6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Irq and clock names were wrong for dsp iommu configuration
for omap4.

Renamed tesla_ick to dsp_fck.
Renamed INT_44XX_DSP_MMU to OMAP44XX_IRQ_TESLA_MMU.

dsp-iommu is enabled by default.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
---
?arch/arm/mach-omap2/omap-iommu.c | ? ?6 ++----
?1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index ac49384..1be8bcb 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -73,19 +73,17 @@ static struct iommu_device omap4_devices[] = {
? ? ? ? ? ? ? ? ? ? ? ?.da_end = 0xFFFFF000,
? ? ? ? ? ? ? ?},
? ? ? ?},
-#if defined(CONFIG_MPU_TESLA_IOMMU)
? ? ? ?{
? ? ? ? ? ? ? ?.base = OMAP4_MMU2_BASE,
- ? ? ? ? ? ? ? .irq = INT_44XX_DSP_MMU,
+ ? ? ? ? ? ? ? .irq = OMAP44XX_IRQ_TESLA_MMU,
? ? ? ? ? ? ? ?.pdata = {
? ? ? ? ? ? ? ? ? ? ? ?.name = "tesla",
? ? ? ? ? ? ? ? ? ? ? ?.nr_tlb_entries = 32,
- ? ? ? ? ? ? ? ? ? ? ? .clk_name = "tesla_ick",
+ ? ? ? ? ? ? ? ? ? ? ? .clk_name = "dsp_fck",
? ? ? ? ? ? ? ? ? ? ? ?.da_start = 0x0,
? ? ? ? ? ? ? ? ? ? ? ?.da_end = 0xFFFFF000,
? ? ? ? ? ? ? ?},
? ? ? ?},
-#endif
?};
?#define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
?static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
--
1.7.5.4
