From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Nov 2018 13:40:45 -0200
Subject: [PATCH 1/3] ARM: dts: imx31: Fix memory node duplicaton
Message-ID: <1541518847-5640-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx31 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx31.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx31-bug.dts  | 1 +
 arch/arm/boot/dts/imx31-lite.dts | 1 +
 arch/arm/boot/dts/imx31.dtsi     | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
index 6ee4ff8..9eb960c 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -17,6 +17,7 @@
 	compatible = "buglabs,imx31-bug", "fsl,imx31";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>; /* 128M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx31-lite.dts b/arch/arm/boot/dts/imx31-lite.dts
index db52ddc..d17abdf 100644
--- a/arch/arm/boot/dts/imx31-lite.dts
+++ b/arch/arm/boot/dts/imx31-lite.dts
@@ -18,6 +18,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index af7afcc..d7f6fb7 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -10,10 +10,8 @@
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
