From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 10 Nov 2009 00:20:06 +0000
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
Message-ID: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
more generic plat-samsung with less code in the other plat- directories
to make it easier to port new devices and try and clear up some of the
naming issues with newer devices.

Start by creating a small arch/arm/plat-samsung with no actuall code in
so we can move items in as we process them.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/plat-samsung/Kconfig  |   17 +++++++++++++++++
 arch/arm/plat-samsung/Makefile |   11 +++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/Kconfig
 create mode 100644 arch/arm/plat-samsung/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..51a454b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -747,6 +747,7 @@ source "arch/arm/mach-orion5x/Kconfig"
 
 source "arch/arm/mach-kirkwood/Kconfig"
 
+source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s3c64xx/Kconfig"
 source "arch/arm/plat-s3c/Kconfig"
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
new file mode 100644
index 0000000..d5ac9be
--- /dev/null
+++ b/arch/arm/plat-samsung/Kconfig
@@ -0,0 +1,17 @@
+# arch/arm/plat-samsung/Kconfig
+#
+# Copyright 2009 Simtec Electronics
+#
+# Licensed under GPLv2
+
+config PLAT_SAMSUNG
+	bool
+	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX
+	default y
+	help
+	  Base platform code for all Samsung SoC based systems
+
+if PLAT_SAMSUNG
+
+
+endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
new file mode 100644
index 0000000..4478b9f
--- /dev/null
+++ b/arch/arm/plat-samsung/Makefile
@@ -0,0 +1,11 @@
+# arch/arm/plat-s3c64xx/Makefile
+#
+# Copyright 2009 Simtec Electronics
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:= dummy.o
+obj-				:=
+
-- 
1.6.5
