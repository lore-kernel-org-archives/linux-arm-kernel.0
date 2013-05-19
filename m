From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 19 May 2013 23:39:36 +0200
Subject: [RFC PATCH 3/5] ARM: mv78x00: Add infrastructure to support boards
 converted to DT
In-Reply-To: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1368999578-19938-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Kconfig and the Makefile to allow to build the
boards converted to the Device Tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mv78xx0/Kconfig  | 7 +++++++
 arch/arm/mach-mv78xx0/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index f2d309d..2390a6e 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -20,6 +20,13 @@ config MACH_TERASTATION_WXL
 	  Say 'Y' here if you want your kernel to support the
 	  Buffalo WXL Nas.
 
+config ARCH_MV78X00_DT
+	bool "Marvell MV78X00 Flattened Device Tree"
+	select USE_OF
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell MV78X00 using flattened device tree.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makefile
index 7cd0463..8935e48 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-mv78xx0/Makefile
@@ -2,3 +2,4 @@ obj-y				+= common.o mpp.o irq.o pcie.o
 obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
 obj-$(CONFIG_MACH_RD78X00_MASA)	+= rd78x00-masa-setup.o
 obj-$(CONFIG_MACH_TERASTATION_WXL) += buffalo-wxl-setup.o
+obj-$(CONFIG_ARCH_MV78X00_DT)	+= board-dt.o
-- 
1.8.1.2
