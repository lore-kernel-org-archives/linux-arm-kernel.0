From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 31 May 2013 19:02:24 +0200
Subject: [PATCH] arm: allow all architectures to change max zone order
Message-ID: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many multimedia applications on architectures without an
IOMMU need large physically contiguous buffers and so need
to adjust the max zone order of the page allocator.

There is zero reason to not allow this adjustment on arches
other than SHMOBILE.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..6ceace8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1710,7 +1710,7 @@ config HW_PERF_EVENTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
+	int "Maximum zone order"
 	range 11 64 if ARCH_SHMOBILE
 	default "12" if SOC_AM33XX
 	default "9" if SA1111
-- 
1.7.10.4
