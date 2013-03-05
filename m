From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:48 +0100
Subject: [PATCH 8/9] iommu: OMAP: build only on OMAP2+
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP IOMMU driver intentionally fails to build on OMAP1
platforms, so we should not allow enabling it there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu at lists.linux-foundation.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 5c514d07..c332fb9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -130,7 +130,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP2PLUS
 	select IOMMU_API
 
 config OMAP_IOVMM
-- 
1.8.1.2
