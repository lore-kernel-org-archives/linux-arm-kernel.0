From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 12:22:01 +0100
Subject: [PATCH 4/4] ARM i.MX: Add Ka-Ro TX25 devicetree
In-Reply-To: <1352719321-23541-1-git-send-email-s.hauer@pengutronix.de>
References: <1352719321-23541-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352719321-23541-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic support for the Ka-Ro i.MX25 based TX25 board.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts |   44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx25-karo-tx25.dts

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
new file mode 100644
index 0000000..d81f8a0
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2012 Sascha Hauer, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx25.dtsi"
+
+/ {
+	model = "Ka-Ro TX25";
+	compatible = "karo,imx25-tx25", "fsl,imx25";
+
+	memory {
+		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
+	};
+
+	soc {
+		aips at 43f00000 {
+			uart1: serial at 43f90000 {
+				status = "okay";
+			};
+		};
+
+		spba at 50000000 {
+			fec: ethernet at 50038000 {
+				status = "okay";
+				phy-mode = "rmii";
+			};
+		};
+
+		emi at 80000000 {
+			nand at bb000000 {
+				nand-on-flash-bbt;
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.7.10.4
