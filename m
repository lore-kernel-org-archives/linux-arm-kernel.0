From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:34:03 -0200
Subject: [PATCH 3/4] ARM: dts: imx35-eukrea-mbimxsd35-baseboard: Fix the
 'cd-gpios' property
In-Reply-To: <1508193244-14599-1-git-send-email-festevam@gmail.com>
References: <1508193244-14599-1-git-send-email-festevam@gmail.com>
Message-ID: <1508193244-14599-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The GPIO polarity is missing in the cd-gpios property.

Fix it, so that the following build warning is gone:

  DTC     arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb: Warning (gpios_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb400

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index e935713..dfc7f45 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -65,7 +65,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio3 24>;
+	cd-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.7.4
