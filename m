From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 11:20:29 +0200
Subject: [PATCH] dt/bindings: arm-boards: Remove skeleton.dtsi inclusion from
 example
Message-ID: <1477041629-23341-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), including skeleton.dtsi is deprecated.
Hence remove it from the example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/arm-boards | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index ab318a56fca2194f..e667ecbcf226dfe3 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -148,15 +148,14 @@ Example:
 
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "skeleton.dtsi"
 
 / {
 	model = "ARM RealView PB1176 with device tree";
 	compatible = "arm,realview-pb1176";
+	#address-cells = <0>;
+	#size-cells = <1>;
 
 	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "arm,realview-pb1176-soc", "simple-bus";
 		ranges;
 
-- 
1.9.1
