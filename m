From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 18 Apr 2011 13:20:41 +0800
Subject: [PATCH] ARM: pxa: enable AUTO_ZRELADDR and remove now useless
	Makefile.boot
Message-ID: <1303104041-4995-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-pxa/Makefile.boot |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/Makefile.boot

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fdc9d4d..d37b52b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -623,6 +623,7 @@ config ARCH_PXA
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select AUTO_ZRELADDR
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
diff --git a/arch/arm/mach-pxa/Makefile.boot b/arch/arm/mach-pxa/Makefile.boot
deleted file mode 100644
index 1ead671..0000000
--- a/arch/arm/mach-pxa/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	:= 0xa0008000
-
-- 
1.7.1
