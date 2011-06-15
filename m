From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 15 Jun 2011 16:47:25 +0300
Subject: [PATCH] OMAP4: iommu: fix clock name
Message-ID: <1308145645-22882-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0e43327 "OMAP4: clock: Fix clock names and align with hwmod names"
renamed ducati_ick to ipu_fck.

Update OMAP4's iommu_device accordingly, so that omap_iommu_probe
doesn't break when calling clk_get.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 3fc5dc7..e61fead 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -67,7 +67,7 @@ static struct iommu_device omap4_devices[] = {
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
-			.clk_name = "ducati_ick",
+			.clk_name = "ipu_fck",
 			.da_start = 0x0,
 			.da_end = 0xFFFFF000,
 		},
-- 
1.7.1
