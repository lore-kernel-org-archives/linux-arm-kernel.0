From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Jun 2017 18:29:25 +0200
Subject: [PATCH] dt-bindings: usb: exynos-usb: Add missing required VDD
 properties
Message-ID: <20170613162925.21847-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit bd8ce544ec35 ("usb: dwc3: exynos: Make provision for vdd
regulators") vdd33-supply and vdd10-supply are required so document them
in bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index 9b4dbe3b2acc..78ebebb66dad 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -92,6 +92,8 @@ Required properties:
 	   parent's address space
  - clocks: Clock IDs array as required by the controller.
  - clock-names: names of clocks correseponding to IDs in the clock property
+ - vdd10-supply: 1.0V powr supply
+ - vdd33-supply: 3.0V/3.3V power supply
 
 Sub-nodes:
 The dwc3 core should be added as subnode to Exynos dwc3 glue.
@@ -107,6 +109,8 @@ Example:
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+		vdd10-supply = <&ldo11_reg>;
+		vdd33-supply = <&ldo9_reg>;
 
 		dwc3 {
 			compatible = "synopsys,dwc3";
-- 
2.9.3
