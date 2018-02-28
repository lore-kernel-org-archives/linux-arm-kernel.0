From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Feb 2018 23:13:35 -0300
Subject: [PATCH] ARM: dts: mx5: Pass the memory unit-address
Message-ID: <1519784015-16507-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the memory unit-address to fix the following build warnings with W=1:

arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/imx53-tx53-x13x.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

In theses cases an empty memory node is passed, which will be filled
by the bootloader. Passing the memory base address still allows the
bootloader to fill the memory size.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++--
 arch/arm/boot/dts/imx53-tx53.dtsi    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index aa36204..14f4d57 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -52,8 +52,8 @@
 	};
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 90000000 {
+		reg = <0x90000000 0>;
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index e77dd0a..69a2af7 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -50,8 +50,8 @@
 	compatible = "karo,tx53", "fsl,imx53";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 70000000 {
+		reg = <0x70000000 0>;
 	};
 
 	aliases {
-- 
2.7.4
