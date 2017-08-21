From: s-anna@ti.com (Suman Anna)
Date: Mon, 21 Aug 2017 18:48:13 -0500
Subject: [PATCH 3/8] ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 IPUs
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Message-ID: <20170821234818.4755-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMUs within the IPU processor subsystems in DRA7xx SoCs
are very similar to those in OMAP4/OMAP5, so extend the OMAP4
iommu pdata quirks for these MMUs as well.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6b433fce65a5..253315393a29 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -412,7 +412,8 @@ static void __init omap3_pandora_legacy_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
 static struct iommu_platform_data omap4_iommu_pdata = {
 	.reset_name = "mmu_cache",
 	.assert_reset = omap_device_assert_hardreset,
@@ -588,6 +589,10 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 		       &dra7_hsmmc_data_mmc2),
 	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x480ad000, "480ad000.mmc",
 		       &dra7_hsmmc_data_mmc3),
+	OF_DEV_AUXDATA("ti,dra7-iommu", 0x55082000, "55082000.mmu",
+		       &omap4_iommu_pdata),
+	OF_DEV_AUXDATA("ti,dra7-iommu", 0x58882000, "58882000.mmu",
+		       &omap4_iommu_pdata),
 #endif
 	/* Common auxdata */
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
-- 
2.13.1
