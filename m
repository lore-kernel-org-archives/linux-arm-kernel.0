From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 24 May 2016 11:12:29 -0500
Subject: [PATCH] ARM: OMAP2+: Select OMAP_INTERCONNECT for SOC_AM43XX
Message-ID: <4af329be31b140a7cd71351cf8f2d2006194e42b.1464105749.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM43XX SoCs make use of the omap_l3_noc driver so explicitly select
OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it always gets
enabled for AM43XX only builds.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
Based on next-20160524.

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 415a0bd0cda6..efbc4649a3c5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -69,6 +69,7 @@ config SOC_AM43XX
 	select HAVE_ARM_TWD
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select OMAP_INTERCONNECT
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.7.3
