From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 15 Oct 2017 18:19:04 -0200
Subject: [PATCH 2/2] ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply' property
In-Reply-To: <1508098744-12099-1-git-send-email-festevam@gmail.com>
References: <1508098744-12099-1-git-send-email-festevam@gmail.com>
Message-ID: <1508098744-12099-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

According to Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt,
the correct property for specifying the PCIe regulator is 'vpcie-supply',
so use the correct one.

Cc: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index fe6ab0a..5c1b1c3 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -362,7 +362,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio1 26 GPIO_ACTIVE_LOW>;
-	vdd-supply = <&reg_pcie_power_on_gpio>;
+	vpcie-supply = <&reg_pcie_power_on_gpio>;
 	status = "okay";
 };
 
-- 
2.7.4
