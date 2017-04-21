From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 21 Apr 2017 11:52:35 +0800
Subject: [PATCH 2/3] arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC
 HS200 on QDS
In-Reply-To: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1492746756-12024-3-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to enable SD UHS-I mode on LS208xRDB and eMMC HS200
mode on LS208xQDS in dts. Also, the eSDHC peripheral clock must be
used instead of platform clock to support these modes.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 8b62048..fc8b787 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -45,6 +45,7 @@
  */
 
 &esdhc {
+	mmc-hs200-1_8v;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 3737587..45b45d3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -45,6 +45,10 @@
  */
 
 &esdhc {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index abb2fff..92f7c55 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -471,7 +471,7 @@
 			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
-			clock-frequency = <0>;	/* Updated by bootloader */
+			clocks = <&clockgen 4 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
-- 
2.1.0.27.g96db324
