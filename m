From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:39 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2: add sfrbu
Message-ID: <20170202185139.21601-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SFRBU, the Special Function Registers Backup manage specific aspects of the
integrated memory, bridge implementations, processor and other
functionality not controlled elsewhere.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 3 ++-
 arch/arm/boot/dts/sama5d2.dtsi                       | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 29737b9b616e..799af90dd75b 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -217,7 +217,8 @@ memory, bridge implementations, processor and other functionality not controlled
 elsewhere.
 
 required properties:
-- compatible: Should be "atmel,<chip>-sfr", "syscon".
+- compatible: Should be "atmel,<chip>-sfr", "syscon" or
+	"atmel,<chip>-sfrbu", "syscon"
   <chip> can be "sama5d3", "sama5d4" or "sama5d2".
 - reg: Should contain registers location and length
 
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ceb9783ff7e1..111470359235 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1279,6 +1279,11 @@
 				status = "okay";
 			};
 
+			sfrbu: sfr at fc05c000 {
+				compatible = "atmel,sama5d2-sfrbu", "syscon";
+				reg = <0xfc05c000 0x20>;
+			};
+
 			chipid at fc069000 {
 				compatible = "atmel,sama5d2-chipid";
 				reg = <0xfc069000 0x8>;
-- 
2.11.0
