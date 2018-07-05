From: frieder.schrempf@exceet.de (Frieder Schrempf)
Date: Thu,  5 Jul 2018 13:15:03 +0200
Subject: [PATCH v2 07/12] arm64: dts: Reflect change of FSL QSPI driver and
 remove unused properties
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Message-ID: <1530789310-16254-8-git-send-email-frieder.schrempf@exceet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSL QSPI driver was moved to the SPI framework and it now
acts as a SPI controller. Therefore the subnodes need to set
spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

Also the properties 'num-cs' and 'bus-num' were never read by the
driver and can be removed.

The property 'fsl,qspi-has-second-chip' is not needed anymore
and will be removed after the old driver was disabled to avoid
breaking fsl-ls1046a-rdb.dts.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 6341281..31e7b31 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -170,7 +170,6 @@
 };
 
 &qspi {
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s at 0 {
@@ -178,6 +177,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 434383b..dc10105 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -198,8 +198,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fl128s at 0 {
@@ -207,6 +205,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 5dc2782..1848c33 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -136,8 +136,6 @@
 };
 
 &qspi {
-	num-cs = <2>;
-	bus-num = <0>;
 	status = "okay";
 
 	qflash0: s25fs512s at 0 {
@@ -145,6 +143,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
@@ -153,6 +153,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 1de6188..fc62ed9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -170,6 +170,8 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 	flash2: s25fl256s1 at 2 {
@@ -177,6 +179,8 @@
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 		reg = <2>;
 	};
 };
-- 
2.7.4
