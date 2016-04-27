From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 27 Apr 2016 12:27:52 -0300
Subject: [PATCH v2] ARM: dts: imx28-m28: Remove unneeded partition nodes
Message-ID: <1461770872-26510-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtdparts is passed from command line, so there is no need to have a
default partitioning in device-tree.

Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Remove all partition nodes

 arch/arm/boot/dts/imx28-m28.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 759cc56..6cebaa6 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -27,32 +27,6 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
-
-				partition at 0 {
-					label = "bootloader";
-					reg = <0x00000000 0x00300000>;
-					read-only;
-				};
-
-				partition at 1 {
-					label = "environment";
-					reg = <0x00300000 0x00080000>;
-				};
-
-				partition at 2 {
-					label = "redundant-environment";
-					reg = <0x00380000 0x00080000>;
-				};
-
-				partition at 3 {
-					label = "kernel";
-					reg = <0x00400000 0x00400000>;
-				};
-
-				partition at 4 {
-					label = "filesystem";
-					reg = <0x00800000 0x0f800000>;
-				};
 			};
 		};
 
-- 
1.9.1
