From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  1 Apr 2015 09:03:45 -0300
Subject: [PATCH] ARM: dts: hummingboard: Remove unneeded 'fsl,mode' property
Message-ID: <1427889825-4349-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6qdl-hummingboard boards use sgtl5000 codec and the machine file 
(imx-sgtl5000) already sets SSI in slave mode and codec in master mode, so there
is no need for having the 'fsl,mode' property.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 151a3db..1f42c93 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -263,7 +263,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
1.9.1
