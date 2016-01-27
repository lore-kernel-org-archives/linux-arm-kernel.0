From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 Jan 2016 20:24:01 +0000
Subject: [PATCH 3/3] ARM: dts: imx6*-hummingboard: fix pcie reset GPIO
 specification
Message-ID: <E1aOWdF-00058a-0X@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe reset signals are active low, and our GPIO for this is directly
connected to the PCIe reset.  However, as the PCIe driver does not use
the flag, the specification of '0' flags (which means active high) has
not been noticed.  Correct this oversight, and switch to using the
GPIO flag definitions instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 3a06516fe7a9..258107246d64 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -253,7 +253,7 @@
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard_pcie_reset>;
-	reset-gpio = <&gpio3 4 0>;
+	reset-gpio = <&gpio3 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.1.0
