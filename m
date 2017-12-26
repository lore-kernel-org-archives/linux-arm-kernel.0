From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Dec 2017 15:55:58 -0200
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard2: Remove leading zero in unit
 address
Message-ID: <1514310958-3792-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove the leading zero from unit address to fix the following build
warning with W=1:

arch/arm/boot/dts/imx6dl-hummingboard2.dtb: Warning (unit_address_format): Node /soc/aips-bus at 2100000/i2c at 21a0000/codec at 0a unit name should not have leading 0s

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 117c4da..dffbc92 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -188,7 +188,7 @@
 		reg = <0x68>;
 	};
 
-	sgtl5000: codec at 0a {
+	sgtl5000: codec at a {
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
-- 
2.7.4
