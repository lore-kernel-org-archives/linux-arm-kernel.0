From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 23 Nov 2018 11:25:19 -0200
Subject: [PATCH] ARM: dts: imx50: Fix memory node duplicaton
Message-ID: <1542979519-31747-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx50-evk has duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx50.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx50-evk.dts | 1 +
 arch/arm/boot/dts/imx50.dtsi    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 682a997..a25da41 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -12,6 +12,7 @@
 	compatible = "fsl,imx50-evk", "fsl,imx50";
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 95b7fba..8be4ff4 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -22,10 +22,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
-- 
2.7.4
