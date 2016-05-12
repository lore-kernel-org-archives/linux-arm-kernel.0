From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 12 May 2016 13:20:52 -0500
Subject: [PATCH] ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata
Message-ID: <1463077252-13078-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch explicitly enables the fixes for the below errata applicable
for AM43x Socs as was done for OMAP4.

754322: Faulty MMU translations following ASID switch

775420: A data cache maintenance operation which aborts,
        followed by an ISB, without any DSB in-between,
        might lead to deadlock

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0517f0c1581a..f9deed2e6ef5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -67,6 +67,8 @@ config SOC_AM43XX
 	select HAVE_ARM_SCU
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select HAVE_ARM_TWD
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.7.3
