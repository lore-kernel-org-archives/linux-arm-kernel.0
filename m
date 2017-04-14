From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Apr 2017 00:09:43 +0300
Subject: [PATCH 2/3] ARM: dts: sk-rzg1m: add SCIF0 pins
Message-ID: <20170414211509.818645915@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0 pin data to the SK-RZG1M board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
+++ renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the SK-RZG1M board
  *
- * Copyright (C) 2016 Cogent Embedded, Inc.
+ * Copyright (C) 2016-2017 Cogent Embedded, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -39,7 +39,17 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
