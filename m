From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  4 Oct 2014 13:58:35 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-gw5x: Remove unneeded 'fsl,
 mode' property
Message-ID: <1412441916-16349-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6qdl-gw5x boards use sgtl5000 codec and the machine file (imx-sgtl5000)
already sets SSI in slave mode and codec in master mode, so there is no need
for having this property.

Cc: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 2 --
 3 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index d3c0bf5..b5756c2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -282,7 +282,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index cade1bd..86f03c1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -287,7 +287,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index cf13239..4a8d97f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -376,12 +376,10 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
1.9.1
