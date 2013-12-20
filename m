From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 20 Dec 2013 11:47:12 -0700
Subject: [PATCH V2 6/7] ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC
 interrupt.
In-Reply-To: <1387565233-16144-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387565233-16144-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387565233-16144-7-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works around a hardware bug.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
This has not been tested.
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 26fa0e5..088b0d2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -44,6 +44,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
@@ -77,7 +79,7 @@
 		};
 
 		pinctrl_enet: enetgrp {
-			fsl,pins = <MX6QDL_ENET_PINGRP2>;
+			fsl,pins = <MX6QDL_ENET_PINGRP2_GPIO6>;
 		};
 
 		pinctrl_gpmi_nand: gpminandgrp {
-- 
1.8.1.2
