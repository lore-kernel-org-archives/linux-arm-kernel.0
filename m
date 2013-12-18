From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 18 Dec 2013 15:41:37 -0700
Subject: [PATCH V1 7/7] ARM: dts: imx6q-arm2: use GPIO_6 for FEC interrupt.
In-Reply-To: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387406497-26430-8-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works around a hardware bug.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
This has not been tested
---
 arch/arm/boot/dts/imx6q-arm2.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 9c00b73..631a426 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -75,7 +75,7 @@
 		};
 
 		pinctrl_enet: enetgrp {
-			fsl,pins = <MX6QDL_ENET_PINGRP2>;
+			fsl,pins = <MX6QDL_ENET_PINGRP2_GPIO6>;
 		};
 
 		pinctrl_gpmi_nand: gpminandgrp {
@@ -115,6 +115,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
-- 
1.8.1.2
