From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Tue, 9 May 2017 10:37:06 +0800
Subject: [v3, 2/5] arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
In-Reply-To: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
References: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1494297429-12083-3-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to enable SD UHS-I mode and eMMC HS200 mode on
LS1046ARDB in dts. Also, the eSDHC peripheral clock must be used
instead of platform clock to support these modes.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Sorted the node.
Changes for v3:
	- None.
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index c5361e9..2d28726 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -72,6 +72,14 @@
 	status = "okay";
 };
 
+&esdhc {
+	mmc-hs200-1_8v;
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 7ef2b9f..5975d30 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -210,10 +210,10 @@
 		};
 
 		esdhc: esdhc at 1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <0>;
+			clocks = <&clockgen 2 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
-- 
2.1.0.27.g96db324
