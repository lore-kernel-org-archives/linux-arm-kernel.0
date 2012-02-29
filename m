From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:20:53 +0100
Subject: [PATCH 2/3] ARM i.MX: Add phytec phycore-i.MX27 (aka pcm038)
 devicetree support
In-Reply-To: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330503654-2197-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts |   76 ++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore.dts

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
new file mode 100644
index 0000000..a51a08f
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -0,0 +1,76 @@
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
+/include/ "imx27.dtsi"
+
+/ {
+	model = "Phytec pcm038";
+	compatible = "phytec,imx27-pcm038", "fsl,imx27";
+
+	memory {
+		reg = <0x0 0x0>;
+	};
+
+	soc {
+		aipi at 10000000 { /* aipi */
+
+			wdog at 10002000 {
+				status = "okay";
+			};
+
+			uart at 1000a000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
+			uart at 1000b000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
+			uart at 1000c000 {
+				fsl,uart-has-rtscts;
+				status = "okay";
+			};
+
+			fec at 1002b000 {
+				status = "okay";
+			};
+
+			i2c at 1001d000 {
+				clock-frequency = <400000>;
+				status = "okay";
+				at24 at 4c {
+					compatible = "at,24c32";
+					pagesize = <32>;
+					reg = <0x52>;
+				};
+				pcf8563 at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+				};
+				lm75 at 4a {
+					compatible = "national,lm75";
+					reg = <0x4a>;
+				};
+			};
+		};
+	};
+
+	nor_flash at c0000000 {
+		compatible = "cfi-flash";
+		bank-width = <2>;
+		reg = <0xc0000000 0x02000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
1.7.9.1
