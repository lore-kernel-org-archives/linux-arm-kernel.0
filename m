From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 18:37:41 +0100
Subject: [PATCH v3 4/4] ARM: dts: Add dts file for S3C6410-based Mini6410 board
In-Reply-To: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
References: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361036261-8315-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree sources for FriendlyARM Mini6410 board
based on Samsung S3C6410 SoC.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/s3c6410-mini6410.dts | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fe69349..7a5480c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -123,6 +123,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	hrefprev60.dtb \
 	hrefv60plus.dtb \
 	ccu9540.dtb
+dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
new file mode 100644
index 0000000..9ac82c2
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -0,0 +1,50 @@
+/*
+ * Samsung's S3C6410 based Mini6410 board device tree source
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Device tree source file for FriendlyARM Mini6410 board which is based on
+ * Samsung's S3C6410 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "s3c6410.dtsi"
+
+/ {
+	model = "FriendlyARM Mini6410 board based on S3C6410";
+	compatible = "friendlyarm,mini6410", "samsung,s3c6410";
+
+	memory {
+		reg = <0x50000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
+	};
+
+	serial at 7f005000 {
+		status = "okay";
+	};
+
+	serial at 7f005400 {
+		status = "okay";
+	};
+
+	serial at 7f005800 {
+		status = "okay";
+	};
+
+	serial at 7f005c00 {
+		status = "okay";
+	};
+
+	sdhci at 7c200000 {
+		bus-width = <4>;
+		non-removable;
+		status = "okay";
+	};
+};
-- 
1.8.1.2
