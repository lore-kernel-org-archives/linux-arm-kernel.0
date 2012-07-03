From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Tue,  3 Jul 2012 16:20:42 +0200
Subject: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
Message-ID: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
of consistent DMA memory (da8xx frame buffer driver).

Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e876819..ff14c1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1725,8 +1725,9 @@ config HW_PERF_EVENTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
-	range 11 64 if ARCH_SHMOBILE
+	int "Maximum zone order"
+	depends on ARCH_SHMOBILE || SOC_AM33XX
+	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
 	default "9" if SA1111
 	default "11"
 	help
-- 
1.7.7
