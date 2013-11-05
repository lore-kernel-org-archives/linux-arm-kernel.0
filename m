From: josh.wu@atmel.com (Josh Wu)
Date: Tue,  5 Nov 2013 14:58:09 +0800
Subject: [PATCH 2/2] ARM: at91: sama5d3/dt: add sama5d36ek dts file
In-Reply-To: <1383634689-15343-1-git-send-email-josh.wu@atmel.com>
References: <1383634689-15343-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1383634689-15343-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dts file to support sama5d36ek board.

Also update the the comments for sama5d36 in sama5d3.dtsi.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/Makefile       |    1 +
 arch/arm/boot/dts/sama5d3.dtsi   |    2 +-
 arch/arm/boot/dts/sama5d36ek.dts |   52 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sama5d36ek.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 802720e..1eccf61 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
+dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
 
 dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b7f4961..5bcd9b4 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1,6 +1,6 @@
 /*
  * sama5d3.dtsi - Device Tree Include file for SAMA5D3 family SoC
- *                applies to SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35 SoC
+ *                applies to SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36 SoC
  *
  *  Copyright (C) 2013 Atmel,
  *                2013 Ludovic Desroches <ludovic.desroches@atmel.com>
diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
new file mode 100644
index 0000000..68d0227
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -0,0 +1,52 @@
+/*
+ * sama5d36ek.dts - Device Tree file for SAMA5D36-EK board
+ *
+ *  Copyright (C) 2013 Atmel,
+ *                2013 Josh Wu <josh.wu@atmel.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "sama5d3xmb.dtsi"
+#include "sama5d3xdm.dtsi"
+
+/ {
+	model = "Atmel SAMA5D36-EK";
+	compatible = "atmel,sama5d36ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
+
+	ahb {
+		apb {
+			spi0: spi at f0004000 {
+				status = "okay";
+			};
+
+			ssc0: ssc at f0008000 {
+				status = "okay";
+			};
+
+			can0: can at f000c000 {
+				status = "okay";
+			};
+
+			i2c0: i2c at f0014000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at f0018000 {
+				status = "okay";
+			};
+
+			macb0: ethernet at f0028000 {
+				status = "okay";
+			};
+
+			macb1: ethernet at f802c000 {
+				status = "okay";
+			};
+		};
+	};
+
+	sound {
+		status = "okay";
+	};
+};
-- 
1.7.10
