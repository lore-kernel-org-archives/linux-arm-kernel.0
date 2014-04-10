From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Apr 2014 15:26:55 +0800
Subject: [PATCH] ARM: dts: imx6q-gw5xxx: remove dead 'crtcs' property
Message-ID: <1397114815-19694-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit (655b43c staging: imx-drm-core: Use OF graph to find
components and connections between encoder and crtcs), 'crtcs' becomes a
dead property.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 3 ---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 902f983..e51bb3f 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -487,9 +487,6 @@
 
 &ldb {
 	status = "okay";
-	lvds-channel at 0 {
-		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8e99c9a..035d3a8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -436,9 +436,6 @@
 
 &ldb {
 	status = "okay";
-	lvds-channel at 0 {
-		crtcs = <&ipu1 0>, <&ipu1 1>;
-	};
 };
 
 &pcie {
-- 
1.8.3.2
