From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 19:01:14 +0100
Subject: [PATCH 3/3] arm: dts: owl-s500: Add Sparky
In-Reply-To: <20171114180114.26408-1-afaerber@suse.de>
References: <20171114180114.26408-1-afaerber@suse.de>
Message-ID: <20171114180114.26408-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Device Tree for the Allo.com Sparky SBC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile            |  3 ++-
 arch/arm/boot/dts/owl-s500-sparky.dts | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-sparky.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..ad77f7656a70 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -707,7 +707,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-rd88f5182-nas.dtb
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
-	owl-s500-guitar-bb-rev-b.dtb
+	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-sparky.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
 dtb-$(CONFIG_ARCH_OXNAS) += \
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
new file mode 100644
index 000000000000..f620548c6c0b
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -0,0 +1,44 @@
+/*
+ * Allo.com Sparky
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
+	compatible = "allo,sparky", "actions,s500";
+	model = "Allo.com Sparky";
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
+		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
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
2.13.6
