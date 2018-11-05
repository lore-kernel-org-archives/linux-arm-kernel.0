From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Nov 2018 16:22:58 -0200
Subject: [PATCH 2/2] ARM: dts: imx53: Fix memory node duplicaton
In-Reply-To: <1541442178-16051-1-git-send-email-festevam@gmail.com>
References: <1541442178-16051-1-git-send-email-festevam@gmail.com>
Message-ID: <1541442178-16051-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx53 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx53.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx53-cx9020.dts      | 1 +
 arch/arm/boot/dts/imx53-m53.dtsi        | 1 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 1 +
 arch/arm/boot/dts/imx53-smd.dts         | 1 +
 arch/arm/boot/dts/imx53-tqma53.dtsi     | 1 +
 arch/arm/boot/dts/imx53-tx53.dtsi       | 1 +
 arch/arm/boot/dts/imx53-usbarmory.dts   | 1 +
 arch/arm/boot/dts/imx53.dtsi            | 2 --
 8 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
index cf70ebc..c875e23 100644
--- a/arch/arm/boot/dts/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -22,6 +22,7 @@
 	};
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index ce45f08..db2e5bc 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -16,6 +16,7 @@
 	compatible = "aries,imx53-m53", "denx,imx53-m53", "fsl,imx53";
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 50dde84..f00dda3 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -11,6 +11,7 @@
 	};
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 462071c..09071ca 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -12,6 +12,7 @@
 	compatible = "fsl,imx53-smd", "fsl,imx53";
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index a72b898..c77d58f 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -17,6 +17,7 @@
 	compatible = "tq,tqma53", "fsl,imx53";
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
 	};
 
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 54cf3e6..4ab1359 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -51,6 +51,7 @@
 
 	/* Will be filled by the bootloader */
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/imx53-usbarmory.dts
index f6268d0..ee6263d 100644
--- a/arch/arm/boot/dts/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/imx53-usbarmory.dts
@@ -58,6 +58,7 @@
 	};
 
 	memory at 70000000 {
+		device_type = "memory";
 		reg = <0x70000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 207eb55..930e2e1 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -23,10 +23,8 @@
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
