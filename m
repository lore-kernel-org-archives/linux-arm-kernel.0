From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 Oct 2017 18:19:03 -0200
Subject: [PATCH 1/2] ARM: dts: imx6q-novena: Use the 'vpcie-supply' property
Message-ID: <1508098744-12099-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit c26ebe98a103 ("PCI: imx6: Add regulator support"), it is
possible to pass the 'vpcie-supply' property to describe the PCIE supply.

This way we can remove the 'regulator-always-on' property from the
regulator and have a better device tree description.

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-novena.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index d83cfb6..eadc371 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -158,7 +158,6 @@
 		regulator-max-microvolt = <1500000>;
 		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 	};
 
 	reg_sata: regulator-sata {
@@ -447,6 +446,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie_novena>;
 	reset-gpio = <&gpio3 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
-- 
2.7.4
