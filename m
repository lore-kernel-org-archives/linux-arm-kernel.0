From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Fri, 26 Oct 2012 18:29:40 +0200
Subject: [PATCH] Add device tree file for the armadeus apf27
Message-ID: <1351268980-25347-1-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
Signed-off-by: Eric Jarrige <eric.jarrige@armadeus.org>
---
 arch/arm/boot/dts/imx27-apf27.dts |   96 +++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-apf27.dts

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
new file mode 100644
index 0000000..b7d11e0
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2012 Philippe Reynes <tremyfr@yahoo.fr>
+ * Copyright 2012 Armadeus Systems <support@armadeus.com>
+ *
+ * Based on code which is: Copyright 2012 Sascha Hauer, Pengutronix
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
+/include/ "imx27.dtsi"
+
+/ {
+	model = "Armadeus apf27";
+	compatible = "armadeus,imx27-apf27", "fsl,imx27";
+
+	memory {
+		reg = <0xa0000000 0x04000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc26m {
+			compatible = "fsl,imx-osc26m", "fixed-clock";
+			clock-frequency = <33554432>;
+		};
+	};
+
+	soc {
+		aipi at 10000000 {
+			wdog at 10002000 {
+				status = "okay";
+			};
+
+			serial at 1000a000 {
+				status = "okay";
+			};
+
+			ethernet at 1002b000 {
+				status = "okay";
+			};
+
+		};
+
+		nand at d8000000 {
+			status = "okay";
+			nand-bus-width = <16>;
+			nand-ecc-mode = "hw";
+			nand-on-flash-bbt;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0 0x100000>;
+			};
+
+			partition at 100000 {
+				label = "env";
+				reg = <0x100000 0x80000>;
+			};
+
+			partition at 180000 {
+				label = "env2";
+				reg = <0x180000 0x80000>;
+			};
+
+			partition at 200000 {
+				label = "firmware";
+				reg = <0x200000 0x80000>;
+			};
+
+			partition at 280000 {
+				label = "dtb";
+				reg = <0x280000 0x80000>;
+			};
+
+			partition at 300000 {
+				label = "kernel";
+				reg = <0x300000 0x500000>;
+			};
+
+			partition at 800000 {
+				label = "rootfs";
+				reg = <0x800000 0xf800000>;
+			};
+		};
+
+	};
+
+};
-- 
1.7.4.4
