From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:39 +0200
Subject: [PATCH 07/26] ARM: pxa: mbxfb: disable broken debugfs code
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code has not worked for a long time, and even the
Makefile entry for building the file was misspelled.
Mark it as broken.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/Kconfig      |    2 +-
 drivers/video/mbx/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..45494c0 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1932,7 +1932,7 @@ config FB_MBX
 
 config FB_MBX_DEBUG
        bool "Enable debugging info via debugfs"
-       depends on FB_MBX && DEBUG_FS
+       depends on FB_MBX && DEBUG_FS && BROKEN
        default n
        ---help---
          Enable this if you want debugging information using the debug
diff --git a/drivers/video/mbx/Makefile b/drivers/video/mbx/Makefile
index 16c1165..a315abc 100644
--- a/drivers/video/mbx/Makefile
+++ b/drivers/video/mbx/Makefile
@@ -1,4 +1,4 @@
 # Makefile for the 2700G controller driver.
 
 obj-$(CONFIG_FB_MBX)	   += mbxfb.o
-obj-$(CONFIG_FB_MBX_DEBUG) += mbxfbdebugfs.o
+obj-$(CONFIG_FB_MBX_DEBUG) += mbxdebugfs.o
-- 
1.7.5.4
