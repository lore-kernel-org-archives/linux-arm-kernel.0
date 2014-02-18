From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 18 Feb 2014 16:40:04 -0300
Subject: [PATCH] ARM: dts: imx6sl-evk: Keep VGEN1 regulator always enabled
Message-ID: <1392752404-524-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx6sl-evk board the VGEN1 regulator powers up the NVCC_1.2V domain of the
imx6sl SoC, so we need to keep it always powered.

This problem has been observed by the fact that a GPIO connected to an LED could
not work when the PMIC driver was enabled.

Keeping VGEN1 regulator always enabled fixes the problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 889422c..2ae933b 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -195,6 +195,8 @@
 			vgen1_reg: vgen1 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1550000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			vgen2_reg: vgen2 {
-- 
1.8.1.2
