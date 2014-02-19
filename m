From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Feb 2014 02:20:43 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add Ether DT support
In-Reply-To: <201402200218.23099.sergei.shtylyov@cogentembedded.com>
References: <201402200218.23099.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402200220.44822.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7790 part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- removed now redundant "interrupt-parent" property;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -1,7 +1,8 @@
 /*
  * Device Tree Source for the r8a7790 SoC
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -379,6 +380,17 @@
 		status = "disabled";
 	};
 
+	ether: ethernet at ee700000 {
+		compatible = "renesas,ether-r8a7790";
+		reg = <0 0xee700000 0 0x400>;
+		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
+		phy-mode = "rmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sata0: sata at ee300000 {
 		compatible = "renesas,sata-r8a7790";
 		reg = <0 0xee300000 0 0x2000>;
