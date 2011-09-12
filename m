From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 12 Sep 2011 19:46:56 +0300
Subject: [PATCH 01/10] hwspinlock/core: simplify Kconfig
In-Reply-To: <1315846025-11453-1-git-send-email-ohad@wizery.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Message-ID: <1315846025-11453-2-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify hwspinlock's Kconfig by making the global CONFIG_HWSPINLOCK
entry invisible; users will just select it when needed.

This also prepares the ground for adding hwspinlock support for other
platforms (the 'depends on ARCH_OMAP4' was rather hideous, and while
we're at it, a dedicated menu is added).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/hwspinlock/Kconfig |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 1f29bab..c8e7bda 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -2,22 +2,20 @@
 # Generic HWSPINLOCK framework
 #
 
+# HWSPINLOCK always gets selected by whoever wants it.
 config HWSPINLOCK
-	tristate "Generic Hardware Spinlock framework"
-	depends on ARCH_OMAP4
-	help
-	  Say y here to support the generic hardware spinlock framework.
-	  You only need to enable this if you have hardware spinlock module
-	  on your system (usually only relevant if your system has remote slave
-	  coprocessors).
+	tristate
 
-	  If unsure, say N.
+menu "Hardware Spinlock drivers"
 
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
-	depends on HWSPINLOCK && ARCH_OMAP4
+	depends on ARCH_OMAP4
+	select HWSPINLOCK
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
 	  introduced in OMAP4).
 
 	  If unsure, say N.
+
+endmenu
-- 
1.7.4.1
