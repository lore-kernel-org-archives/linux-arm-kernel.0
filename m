From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 Aug 2016 16:34:26 -0300
Subject: [PATCH 3/3] ARM: dts: imx28: Fix build warnings with W=1
In-Reply-To: <1471203266-30414-1-git-send-email-festevam@gmail.com>
References: <1471203266-30414-1-git-send-email-festevam@gmail.com>
Message-ID: <1471203266-30414-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

While at it, also pass the 'device_type' property as recommended by the 
ePAPR specification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-apf28.dts            | 3 ++-
 arch/arm/boot/dts/imx28-apx4devkit.dts       | 3 ++-
 arch/arm/boot/dts/imx28-cfa10036.dts         | 3 ++-
 arch/arm/boot/dts/imx28-duckbill.dts         | 3 ++-
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts | 3 ++-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts | 3 ++-
 arch/arm/boot/dts/imx28-evk.dts              | 3 ++-
 arch/arm/boot/dts/imx28-m28.dtsi             | 3 ++-
 arch/arm/boot/dts/imx28-m28cu3.dts           | 3 ++-
 arch/arm/boot/dts/imx28-sps1.dts             | 3 ++-
 arch/arm/boot/dts/imx28-tx28.dts             | 3 ++-
 11 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 070e59c..b6976fb 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -16,7 +16,8 @@
 	model = "Armadeus Systems APF28 module";
 	compatible = "armadeus,imx28-apf28", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 1092b76..ce6115e 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -5,7 +5,8 @@
 	model = "Bluegiga APX4 Development Kit";
 	compatible = "bluegiga,apx4devkit", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 570aa33..d016a3b 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -16,7 +16,8 @@
 	model = "Crystalfontz CFA-10036 Board";
 	compatible = "crystalfontz,cfa10036", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index ce1a7ef..b5bc3f5 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -16,7 +16,8 @@
 	model = "I2SE Duckbill";
 	compatible = "i2se,duckbill", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
index 7c1572c..28dab6d 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
@@ -23,7 +23,8 @@
 	model = "Eukrea Electromatique MBMX283LC";
 	compatible = "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
index e773144..08125e5 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
@@ -22,7 +22,8 @@
 	model = "Eukrea Electromatique MBMX287LC";
 	compatible = "eukrea,mbmx287lc", "eukrea,mbmx283lc", "eukrea,mbmx28lc", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index a5ba669..4cd8216 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -16,7 +16,8 @@
 	model = "Freescale i.MX28 Evaluation Kit";
 	compatible = "fsl,imx28-evk", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 214bb15..1bcba90 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -15,7 +15,8 @@
 	model = "DENX M28";
 	compatible = "denx,m28", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 2df63be..c4c4cc7 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -16,7 +16,8 @@
 	model = "MSR M28CU3";
 	compatible = "msr,m28cu3", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 0ce3cb8..5ddfb16 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -16,7 +16,8 @@
 	model = "SchulerControl GmbH, SC SPS 1";
 	compatible = "schulercontrol,imx28-sps1", "fsl,imx28";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 0ebbc83..b4d4dbb 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -35,7 +35,8 @@
 		usbotg = &usb0;
 	};
 
-	memory {
+	memory at 0 {
+		device_type = "memory";
 		reg = <0 0>; /* will be filled in by U-Boot */
 	};
 
-- 
1.9.1
