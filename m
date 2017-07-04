From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  4 Jul 2017 17:28:22 +0800
Subject: [PATCH] ARM: dts: socfpga: remove num-slots from from socfpga
 platforms
Message-ID: <1499160502-78250-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 1 -
 arch/arm/boot/dts/socfpga_arria5.dtsi             | 1 -
 arch/arm/boot/dts/socfpga_cyclone5.dtsi           | 1 -
 arch/arm/boot/dts/socfpga_vt.dts                  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index 040a164..5822fd2 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -20,7 +20,6 @@
 
 &mmc {
 	status = "okay";
-	num-slots = <1>;
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 8c03729..e59461f 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -30,7 +30,6 @@
 		};
 
 		mmc0: dwmmc0 at ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index a05e3df..68ced67 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -31,7 +31,6 @@
 		};
 
 		mmc0: dwmmc0 at ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index dfe2193..547c386 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -42,7 +42,6 @@
 		};
 
 		dwmmc0 at ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
-- 
1.9.1
