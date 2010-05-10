From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 10 May 2010 12:16:09 +0300
Subject: [PATCH] omap iommu: Make CONFIG_OMAP_IOMMU_DEBUG selectable
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1273482972-5586-6-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This CONFIG_OMAP_IOMMU_DEBUG option cannot be selected because it's
not visible on menu. Make this option selectable.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..78b49a6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -110,8 +110,13 @@ config OMAP_IOMMU
 	tristate
 
 config OMAP_IOMMU_DEBUG
-	depends on OMAP_IOMMU
-	tristate
+       tristate "Export OMAP IOMMU internals in DebugFS"
+       depends on OMAP_IOMMU && DEBUG_FS
+       help
+         Select this to see extensive information about
+         the internal state of OMAP IOMMU in debugfs.
+
+         Say N unless you know you need this.
 
 choice
 	prompt "System timer"
-- 
1.7.1.rc1
