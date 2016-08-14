From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 Aug 2016 16:34:25 -0300
Subject: [PATCH 2/3] ARM: dts: imx23: Fix build warnings with W=1
In-Reply-To: <1471203266-30414-1-git-send-email-festevam@gmail.com>
References: <1471203266-30414-1-git-send-email-festevam@gmail.com>
Message-ID: <1471203266-30414-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

While at it, also pass the 'device_type' property as recommended by the 
ePAPR specification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx23-evk.dts           | 3 ++-
 arch/arm/boot/dts/imx23-olinuxino.dts     | 3 ++-
 arch/arm/boot/dts/imx23-sansa.dts         | 3 ++-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts | 3 ++-
 arch/arm/boot/dts/imx23-xfi3.dts          | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 57e2997..bd06402 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -16,7 +16,8 @@
 	model = "Freescale i.MX23 Evaluation Kit";
 	compatible = "fsl,imx23-evk", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index a8b1c53..109f516 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -19,7 +19,8 @@
 	model = "i.MX23 Olinuxino Low Cost Board";
 	compatible = "olimex,imx23-olinuxino", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 4ec32f4..9cf40d3 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -48,7 +48,8 @@
 	model = "SanDisk Sansa Fuze+";
 	compatible = "sandisk,sansa_fuze_plus", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
index 455169e..aab0293 100644
--- a/arch/arm/boot/dts/imx23-stmp378x_devb.dts
+++ b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
@@ -16,7 +16,8 @@
 	model = "Freescale STMP378x Development Board";
 	compatible = "fsl,stmp378x-devb", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/imx23-xfi3.dts
index 025cf94..2b5df8d 100644
--- a/arch/arm/boot/dts/imx23-xfi3.dts
+++ b/arch/arm/boot/dts/imx23-xfi3.dts
@@ -48,7 +48,8 @@
 	model = "Creative ZEN X-Fi3";
 	compatible = "creative,x-fi3", "fsl,imx23";
 
-	memory {
+	memory at 40000000 {
+		device_type = "memory";
 		reg = <0x40000000 0x04000000>;
 	};
 
-- 
1.9.1
