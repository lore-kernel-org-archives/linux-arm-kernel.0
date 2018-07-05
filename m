From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:31 +0200
Subject: [PATCH v3 17/23] dt-bindings: cp110: update documentation since DT
 de-duplication
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-18-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CP110 master/slave DT files have been merged in a DT de-duplication work
merged in v4.16. Update the syscon documentation accordingly to match
the current state of the DT nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/marvell/cp110-system-controller.txt           | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 56e7fb1153e7..54b0d64ce819 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -163,26 +163,26 @@ Required properties:
 
 Example:
 
-cpm_syscon0: system-controller at 440000 {
+CP110_LABEL(syscon0): system-controller at 440000 {
 	compatible = "syscon", "simple-mfd";
 	reg = <0x440000 0x1000>;
 
-	cpm_clk: clock {
+	CP110_LABEL(clk): clock {
 		compatible = "marvell,cp110-clock";
 		#clock-cells = <2>;
 	};
 
-	cpm_pinctrl: pinctrl {
+	CP110_LABEL(pinctrl): pinctrl {
 		compatible = "marvell,armada-8k-cpm-pinctrl";
 	};
 
-	cpm_gpio1: gpio at 100 {
+	CP110_LABEL(gpio1): gpio at 100 {
 		compatible = "marvell,armada-8k-gpio";
 		offset = <0x100>;
 		ngpios = <32>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-ranges = <&cpm_pinctrl 0 0 32>;
+		gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
 	};
 
 };
-- 
2.14.1
