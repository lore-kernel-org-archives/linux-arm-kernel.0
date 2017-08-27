From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Aug 2017 14:54:25 +0200
Subject: [PATCH 3/3] arm64: dts: realtek: Add ProBox2 Ava
In-Reply-To: <20170827125425.3400-1-afaerber@suse.de>
References: <20170827125425.3400-1-afaerber@suse.de>
Message-ID: <20170827125425.3400-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Device Tree for the PROBOX2 AVA TV Box.
Move common memory reservations into rtd1295.dtsi.

Cc: support at probox2.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 I've been torn on whether this should be just rtd1295-ava.dts?
 The vendor is indicated in the compatible string and model property.
 rtd1295-x9s.dts hadn't sounded unique enough to me, but we might revisit that.
 
 arch/arm64/boot/dts/realtek/Makefile               |  1 +
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts | 31 ++++++++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  6 -----
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  6 +++++
 4 files changed, 38 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 8521e921e59a..f43d0209ded7 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
new file mode 100644
index 000000000000..8e2b0e75298a
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "rtd1295.dtsi"
+
+/ {
+	compatible = "probox2,ava", "realtek,rtd1295";
+	model = "PROBOX2 AVA";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
index 6efa8091bb30..da19faab29d5 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
@@ -6,12 +6,6 @@
 
 /dts-v1/;
 
-/memreserve/	0x0000000000000000 0x0000000000030000;
-/memreserve/	0x000000000001f000 0x0000000000001000;
-/memreserve/	0x0000000000030000 0x00000000000d0000;
-/memreserve/	0x0000000001b00000 0x00000000004be000;
-/memreserve/	0x0000000001ffe000 0x0000000000004000;
-
 #include "rtd1295.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 8ae0949ad89e..c0b48953439a 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -6,6 +6,12 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+/memreserve/	0x0000000000000000 0x0000000000030000;
+/memreserve/	0x000000000001f000 0x0000000000001000;
+/memreserve/	0x0000000000030000 0x00000000000d0000;
+/memreserve/	0x0000000001b00000 0x00000000004be000;
+/memreserve/	0x0000000001ffe000 0x0000000000004000;
+
 #include <dt-bindings/clock/realtek,rtd1295.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/realtek,rtd1295.h>
-- 
2.12.3
