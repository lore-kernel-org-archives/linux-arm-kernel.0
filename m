From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 12:28:13 +0200
Subject: [PATCH v2] dt/bindings: arm-boards: Remove skeleton.dtsi inclusion
 from example
Message-ID: <1477045693-6820-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), including skeleton.dtsi is deprecated.
Hence remove it from the example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
v2:
  - Restore #address-cells/#size-cells in soc subnode,
  - Add Acked-by,
  - Correct #address-cells from <0> to <1>.
---
 Documentation/devicetree/bindings/arm/arm-boards | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index ab318a56fca2194f..b6e810c2781a4ec8 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -148,11 +148,12 @@ Example:
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "skeleton.dtsi"
 
 / {
 	model = "ARM RealView PB1176 with device tree";
 	compatible = "arm,realview-pb1176";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	soc {
 		#address-cells = <1>;
-- 
1.9.1
