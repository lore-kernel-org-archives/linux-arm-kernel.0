From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 Oct 2017 18:53:58 -0200
Subject: [PATCH v2 2/2] ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply' property
In-Reply-To: <1508100838-13406-1-git-send-email-festevam@gmail.com>
References: <1508100838-13406-1-git-send-email-festevam@gmail.com>
Message-ID: <1508100838-13406-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

According to Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt,
the property for specifying the PCIe regulator is 'vpcie-supply', so
use the correct one.

Also fix the polarity of GPIO2_24 so that the regulator can operate
correctly.

Cc: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Also fix the GPIO2_24 polarity. (Christopher)

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index fe6ab0a..bc7587c 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -77,8 +77,7 @@
 		regulator-name = "regulator-pcie-power-on-gpio";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		gpio = <&gpio2 24 GPIO_ACTIVE_LOW>;
 	};
 
 	reg_usb_h1_vbus: usb_h1_vbus {
@@ -362,7 +361,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio1 26 GPIO_ACTIVE_LOW>;
-	vdd-supply = <&reg_pcie_power_on_gpio>;
+	vpcie-supply = <&reg_pcie_power_on_gpio>;
 	status = "okay";
 };
 
-- 
2.7.4
