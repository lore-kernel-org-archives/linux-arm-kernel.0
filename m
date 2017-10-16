From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:40:43 -0200
Subject: [PATCH] ARM: dts: imx25-eukrea-mbimxsd25-baseboard: Fix the
 'cd-gpios' property
Message-ID: <1508193643-30243-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The GPIO polarity is missing in the cd-gpios property.

Fix it, so that the following build warnings are gone:

  DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
  DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
  DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
  DTC     arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000


Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index db39bd6..0f05372 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -64,7 +64,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio1 20>;
+	cd-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.7.4
