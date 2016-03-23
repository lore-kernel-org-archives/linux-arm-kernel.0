From: Gang.Liu@nxp.com (Liu Gang)
Date: Wed, 23 Mar 2016 17:47:21 +0800
Subject: [PATCH v2] gpio/ls1043a: Add compatible "fsl,
 qoriq-gpio" for ls1043a gpio nodes
In-Reply-To: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <1458726442-1851-3-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible "fsl,qoriq-gpio" is used by gpio driver:
drivers/gpio/gpio-mpc8xxx.c to implement general gpio
functionalities.

The chip-specific compatible "fsl,ls1043a-gpio" may be
used to fix potential gpio IP block errata or other
chip-specific gpio issues.

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
v2 changes:
	Add chip-specific compatible based on Scott's
	comment.

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index be72bf5..bf70b27 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -284,7 +284,7 @@
 		};
 
 		gpio1: gpio at 2300000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <0 66 0x4>;
 			gpio-controller;
@@ -294,7 +294,7 @@
 		};
 
 		gpio2: gpio at 2310000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <0 67 0x4>;
 			gpio-controller;
@@ -304,7 +304,7 @@
 		};
 
 		gpio3: gpio at 2320000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <0 68 0x4>;
 			gpio-controller;
@@ -314,7 +314,7 @@
 		};
 
 		gpio4: gpio at 2330000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <0 134 0x4>;
 			gpio-controller;
-- 
2.1.0.27.g96db324
