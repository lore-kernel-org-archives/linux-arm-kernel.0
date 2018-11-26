From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 10:08:56 -0200
Subject: [PATCH 2/2] ARM: dts: imx28: Fix memory node duplicaton
In-Reply-To: <1543234136-6824-1-git-send-email-festevam@gmail.com>
References: <1543234136-6824-1-git-send-email-festevam@gmail.com>
Message-ID: <1543234136-6824-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx28 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx28.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx28-apf28.dts              | 1 +
 arch/arm/boot/dts/imx28-apx4devkit.dts         | 1 +
 arch/arm/boot/dts/imx28-cfa10036.dts           | 1 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts     | 1 +
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts | 1 +
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts     | 1 +
 arch/arm/boot/dts/imx28-duckbill-2.dts         | 1 +
 arch/arm/boot/dts/imx28-duckbill.dts           | 1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts   | 1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts   | 1 +
 arch/arm/boot/dts/imx28-evk.dts                | 1 +
 arch/arm/boot/dts/imx28-m28.dtsi               | 1 +
 arch/arm/boot/dts/imx28-m28cu3.dts             | 1 +
 arch/arm/boot/dts/imx28-m28evk.dts             | 1 +
 arch/arm/boot/dts/imx28-sps1.dts               | 1 +
 arch/arm/boot/dts/imx28-ts4600.dts             | 1 +
 arch/arm/boot/dts/imx28-tx28.dts               | 1 +
 arch/arm/boot/dts/imx28.dtsi                   | 2 --
 18 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index bab7834..b6976fb 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -17,6 +17,7 @@
 	compatible = "armadeus,imx28-apf28", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 6c9b498..3a184d1 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -7,6 +7,7 @@
 	compatible = "bluegiga,apx4devkit", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 8337ca2..d3e3622 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -17,6 +17,7 @@
 	compatible = "crystalfontz,cfa10036", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
index f4f2b3d..19957c2 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-485.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
@@ -20,6 +20,7 @@
 	compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
index 71d0fcb..4982131 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -21,6 +21,7 @@
 	compatible = "i2se,duckbill-2-enocean", "i2se,duckbill-2", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
index 6580ec6..d38d35b 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
@@ -24,6 +24,7 @@
 	};
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/imx28-duckbill-2.dts
index 693634e..38160fb 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2.dts
@@ -20,6 +20,7 @@
 	compatible = "i2se,duckbill-2", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index 16f5244..7139c07 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -19,6 +19,7 @@
 	compatible = "i2se,duckbill", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
index b70f334..28dab6d 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
@@ -24,6 +24,7 @@
 	compatible = "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
index 65efb78..7c3d552 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
@@ -23,6 +23,7 @@
 	compatible = "eukrea,mbmx287lc", "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 5778300..96c1d10 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -10,6 +10,7 @@
 	compatible = "fsl,imx28-evk", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 0ec415e..298ad28 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -16,6 +16,7 @@
 	compatible = "aries,m28", "denx,m28", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 8883d36..ece3310 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -17,6 +17,7 @@
 	compatible = "msr,m28cu3", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 893886d..7d64301 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -1,4 +1,5 @@
 /*
+
  * Copyright (C) 2012 Marek Vasut <marex@denx.de>
  *
  * The code contained herein is licensed under the GNU General Public
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index ea9212f..42c88a6 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -17,6 +17,7 @@
 	compatible = "schulercontrol,imx28-sps1", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
index dccdd6b..e3fd411 100644
--- a/arch/arm/boot/dts/imx28-ts4600.dts
+++ b/arch/arm/boot/dts/imx28-ts4600.dts
@@ -20,6 +20,7 @@
 	compatible = "technologic,imx28-ts4600", "fsl,imx28";
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x10000000>;   /* 256MB */
 	};
 
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index b8f4643..164254c 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -66,6 +66,7 @@
 	};
 
 	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0>; /* will be filled in by U-Boot */
 	};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2b7efb6..e14d8ef 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -14,10 +14,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &mac0;
-- 
2.7.4
