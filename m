From: yinbo.zhu@nxp.com (yinbo.zhu)
Date: Wed, 31 May 2017 17:32:47 +0800
Subject: [PATCH] arm64: dts: ls208xa: disable SD UHS-I modes by default on RDB
Message-ID: <1496223167-33840-1-git-send-email-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently SD UHS-I modes were enabled by default on LS208xARDB boards,
but the new LS2088ARDB RevF board didn't support them any more since SDHC
circuit had been reworked. This patch is to disable SD UHS-I modes by default
in case of any issue on LS2088ARDB RevF

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 3a944bb..f06b7f5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -45,10 +45,6 @@
  */
 
 &esdhc {
-	sd-uhs-sdr104;
-	sd-uhs-sdr50;
-	sd-uhs-sdr25;
-	sd-uhs-sdr12;
 	status = "okay";
 };
 
-- 
2.1.0.27.g96db324
