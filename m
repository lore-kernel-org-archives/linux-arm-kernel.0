From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 20 Sep 2017 10:56:08 -0300
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: Use the 'vpcie-supply' property
Message-ID: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit c26ebe98a103 ("PCI: imx6: Add regulator support"), it is
possible to pass the 'vpcie-supply' property to describe the PCIE supply.

This way we can remove the 'regulator-always-on' property from the
regulator and have a better device tree description.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index b72b6fa..77f7b12 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -67,7 +67,6 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio3 19 0>;
-			regulator-always-on;
 			enable-active-high;
 		};
 	};
@@ -651,6 +650,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
-- 
2.7.4
