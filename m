From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2018 13:59:44 -0200
Subject: [PATCH 3/4] ARM: dts: imx6sx: Fix memory node duplicaton
In-Reply-To: <1542729585-9330-1-git-send-email-festevam@gmail.com>
References: <1542729585-9330-1-git-send-email-festevam@gmail.com>
Message-ID: <1542729585-9330-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx6sx have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx6sx.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts         | 1 +
 arch/arm/boot/dts/imx6sx-sabreauto.dts           | 1 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi                | 1 +
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts | 1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts      | 1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts   | 1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts       | 1 +
 arch/arm/boot/dts/imx6sx.dtsi                    | 2 --
 8 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index adb5cc7..832b5c5 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -12,6 +12,7 @@
 	compatible = "boundary,imx6sx-nitrogen6sx", "fsl,imx6sx";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 841a27f..48aede5 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -11,6 +11,7 @@
 	compatible = "fsl,imx6sx-sabreauto", "fsl,imx6sx";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 7d7d679..a6ec816 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -21,6 +21,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index 252175b..2bc5162 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
index 40ccdf4..db0feb9 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
@@ -49,6 +49,7 @@
 	compatible = "udoo,neobasic", "fsl,imx6sx";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
index 42bfc8f..5c7a2bb 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
@@ -49,6 +49,7 @@
 	compatible = "udoo,neoextended", "fsl,imx6sx";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
index c84c877..13dfe2a 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
@@ -49,6 +49,7 @@
 	compatible = "udoo,neofull", "fsl,imx6sx";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b79b6c4..2cdcf3e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -15,10 +15,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		can0 = &flexcan1;
-- 
2.7.4
