From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 08:55:23 -0500
Subject: [PATCH 1/3] ARM: OMAP5: use pdata quirks for pinctrl information
In-Reply-To: <1408715725-25919-1-git-send-email-nm@ti.com>
References: <1408715725-25919-1-git-send-email-nm@ti.com>
Message-ID: <1408715725-25919-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide pdata-quirks for OMAP5 processor family.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 90c88d4..edacfed 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -352,6 +352,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
 #endif
+#ifdef CONFIG_SOC_OMAP5
+	OF_DEV_AUXDATA("ti,omap5-padconf", 0x4a002840, "4a002840.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap5-padconf", 0x4ae0c840, "4ae0c840.pinmux", &pcs_pdata),
+#endif
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
 		       &omap4_iommu_pdata),
-- 
1.7.9.5
