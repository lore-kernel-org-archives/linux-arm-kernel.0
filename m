From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 19 Oct 2016 15:44:12 -0500
Subject: [PATCH RESEND] ARM: AM43XX: Select OMAP_INTERCONNECT in Kconfig
Message-ID: <20161019204412.18607-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x makes use of the omap_l3_noc driver so explicitly select
OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it gets enabled
for AM43XX only builds.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
This was supposed to be picked up for v4.7 [1] but doesn't seem to have
ever been merged, maybe it was missed? Here it is again, rebased
on v4.9-rc1.

[1] http://www.spinics.net/lists/linux-omap/msg129708.html

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a9afeebd59f2..0465338183c7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -71,6 +71,7 @@ config SOC_AM43XX
 	select HAVE_ARM_TWD
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select OMAP_INTERCONNECT
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.9.3
