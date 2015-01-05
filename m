From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  5 Jan 2015 13:06:38 +0100
Subject: [PATCH 1/8] ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
In-Reply-To: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1420459605-24561-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system timer register range is also used for the watchdog. Declare it as a
syscon to be able to get a regmap early enough in the boot process

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 562cda9d86d9..938592a3c4e2 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -45,7 +45,7 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st"
+- compatible: Should be "atmel,at91rm9200-st", "syscon"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for the ST which is the IRQ line
   shared across all System Controller members.
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 6c97d4af61ee..f77b15c0b1d1 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -351,7 +351,7 @@
 			};
 
 			st: timer at fffffd00 {
-				compatible = "atmel,at91rm9200-st";
+				compatible = "atmel,at91rm9200-st", "syscon";
 				reg = <0xfffffd00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
-- 
2.1.0
