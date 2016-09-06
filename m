From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:15 -0300
Subject: [PATCH 8/9] ARM: dts: imx27: Fix memory node build warnings with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-9-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

While at it, also pass the 'device_type' property as recommended by the
ePAPR specification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx27-apf27.dts                 | 3 ++-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi      | 3 ++-
 arch/arm/boot/dts/imx27-pdk.dts                   | 3 ++-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi | 3 ++-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi   | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f..357eb55 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -19,7 +19,8 @@
 	model = "Armadeus Systems APF27 module";
 	compatible = "armadeus,imx27-apf27", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 2cf896c..ecdf5e4 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -16,7 +16,8 @@
 	model = "Eukrea CPUIMX27";
 	compatible = "eukrea,cpuimx27", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index d0ef496..0bc8a08 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -16,7 +16,8 @@
 	model = "Freescale i.MX27 Product Development Kit";
 	compatible = "fsl,imx27-pdk", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index 1b62480..d3c3bca 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -17,7 +17,8 @@
 	model = "Phytec pca100";
 	compatible = "phytec,imx27-pca100", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>; /* 128MB */
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index b4e955e..1a73122 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -16,7 +16,8 @@
 	model = "Phytec pcm038";
 	compatible = "phytec,imx27-pcm038", "fsl,imx27";
 
-	memory {
+	memory at a0000000 {
+		device_type = "memory";
 		reg = <0xa0000000 0x08000000>;
 	};
 
-- 
1.9.1
