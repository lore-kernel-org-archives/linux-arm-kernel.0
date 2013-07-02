From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  2 Jul 2013 20:02:29 +0400
Subject: [PATCH 6/6] ARM: dts: imx27-phytec-phycore-som: Using labels for
 reusing UART, I2C and FEC
In-Reply-To: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
References: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372780949-31897-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 63 ++++++++++++--------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index bd7df2e..22d0d27 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -19,39 +19,6 @@
 	memory {
 		reg = <0xa0000000 0x08000000>;
 	};
-
-	soc {
-		aipi at 10000000 { /* aipi1 */
-			serial at 1000a000 {
-				status = "okay";
-			};
-
-			i2c at 1001d000 {
-				clock-frequency = <400000>;
-				status = "okay";
-				at24 at 52 {
-					compatible = "at,24c32";
-					pagesize = <32>;
-					reg = <0x52>;
-				};
-				pcf8563 at 51 {
-					compatible = "nxp,pcf8563";
-					reg = <0x51>;
-				};
-				lm75 at 4a {
-					compatible = "national,lm75";
-					reg = <0x4a>;
-				};
-			};
-		};
-
-		aipi at 10020000 { /* aipi2 */
-			ethernet at 1002b000 {
-				phy-reset-gpios = <&gpio3 30 0>;
-				status = "okay";
-			};
-		};
-	};
 };
 
 &cspi1 {
@@ -163,12 +130,42 @@
 	};
 };
 
+&fec {
+	phy-reset-gpios = <&gpio3 30 0>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	at24 at 52 {
+		compatible = "at,24c32";
+		pagesize = <32>;
+		reg = <0x52>;
+	};
+
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	lm75 at 4a {
+		compatible = "national,lm75";
+		reg = <0x4a>;
+	};
+};
+
 &nfc {
 	nand-bus-width = <8>;
 	nand-ecc-mode = "hw";
 	status = "okay";
 };
 
+&uart1 {
+	status = "okay";
+};
+
 &weim {
 	status = "okay";
 
-- 
1.8.1.5
