From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue,  1 Jun 2010 08:30:40 +0300
Subject: [PATCH 1/8] omap iommu: update ducati mmu irq define name
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Message-ID: <1275370247-15888-1-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kanigeri, Hari <h-kanigeri2@ti.com>

2.6.34-rc6 kernel has the Ducati mmu irq define name changed, which is
resulting in compilation error.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index eb9bee7..f5a1aad 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -59,7 +59,7 @@ static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
 static struct iommu_device omap4_devices[] = {
 	{
 		.base = OMAP4_MMU1_BASE,
-		.irq = INT_44XX_DUCATI_MMU_IRQ,
+		.irq = OMAP44XX_IRQ_DUCATI_MMU,
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
-- 
1.7.1.rc1
