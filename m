From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:16 -0300
Subject: [PATCH 9/9] ARM: dts: imx27-eukrea-mbimxsd27-baseboard: Fix ads7846
 node build warning with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-10-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /soc/aipi at 10000000/cspi at 1000e000/ads7846 has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 27846ff..3178467 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -85,7 +85,7 @@
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	ads7846 {
+	ads7846 at 0 {
 		compatible = "ti,ads7846";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_touch>;
-- 
1.9.1
