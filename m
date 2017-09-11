From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 11 Sep 2017 02:58:05 +0200
Subject: [PATCH 2/2] ARM: dts: owl-s500: Add CubieBoard6
In-Reply-To: <20170911005805.10116-1-afaerber@suse.de>
References: <20170911005805.10116-1-afaerber@suse.de>
Message-ID: <20170911005805.10116-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Device Tree for Cubietech CubieBoard6.

Cc: support at cubietech.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts | 44 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-cubieboard6.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faf46abaa4a2..448e0bd74ab7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -680,6 +680,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-netgear-wnr854t.dtb \
 	orion5x-rd88f5182-nas.dtb
 dtb-$(CONFIG_ARCH_ACTIONS) += \
+	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
new file mode 100644
index 000000000000..ea4e01bce8d1
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -0,0 +1,44 @@
+/*
+ * Cubietech CubieBoard6
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "owl-s500.dtsi"
+
+/ {
+	compatible = "cubietech,cubieboard6", "actions,s500";
+	model = "CubieBoard6";
+
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	uart3_clk: uart3-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&timer {
+	clocks = <&hosc>;
+};
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart3_clk>;
+};
-- 
2.13.5
