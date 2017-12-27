From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 14:23:23 -0200
Subject: [PATCH 1/2] ARM: dts: imx27-eukrea-mbimxsd27-baseboard: Pass missing
 unit address
Message-ID: <1514391804-9518-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

ads7846 is connected to SPI chip select 0, so pass the unit address
accordingly to fix the following build warning with W=1:

arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb: Warning (unit_address_vs_reg): Node /soc/aipi at 10000000/cspi at 1000e000/ads7846 has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index f565357..15145e7 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -84,7 +84,7 @@
 	cs-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	ads7846 {
+	ads7846 at 0 {
 		compatible = "ti,ads7846";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_touch>;
-- 
2.7.4
