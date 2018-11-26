From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 10:40:52 -0200
Subject: [PATCH 1/3] ARM: dts: imx1: Fix memory node duplicaton
Message-ID: <1543236054-10450-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx1 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx1.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx1-ads.dts     | 1 +
 arch/arm/boot/dts/imx1-apf9328.dts | 1 +
 arch/arm/boot/dts/imx1.dtsi        | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index a1d81ba..3459a58 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory at 8000000 {
+		 device_type = "memory";
 		reg = <0x08000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index 11515c0..ee4b1b1 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory at 8000000 {
+		device_type = "memory";
 		reg = <0x08000000 0x00800000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b00ece1..b30448c 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -15,10 +15,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.7.4
