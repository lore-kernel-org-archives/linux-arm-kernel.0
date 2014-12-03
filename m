From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:10 +0100
Subject: [PATCH 11/11] ARM: at91/dt: fix at91 udc compatible strings
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91rm9200, at91sam9260, at91sam9261 and at91sam9263 SoCs have slightly
different UDC IPs.
Those differences were previously handled with cpu_is_at91xx macro which
are about to be dropped for multi-platform support, thus we need to
change compatible strings.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi | 3 ++-
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cb100b0..b43de88 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -848,7 +848,7 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				compatible = "atmel,at91rm9200-udc";
+				compatible = "atmel,at91sam9260-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
 				clocks = <&udc_clk>, <&udpck>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index e52ae97..90f0b59 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -119,11 +119,12 @@
 			};
 
 			usb1: gadget at fffa4000 {
-				compatible = "atmel,at91rm9200-udc";
+				compatible = "atmel,at91sam9261-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
 				clocks = <&udc_clk>, <&udpck>;
 				clock-names = "pclk", "hclk";
+				atmel,matrix = <&matrix>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 51416c7d..2c7ed05 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -817,7 +817,7 @@
 			};
 
 			usb1: gadget at fff78000 {
-				compatible = "atmel,at91rm9200-udc";
+				compatible = "atmel,at91sam9263-udc";
 				reg = <0xfff78000 0x4000>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 2>;
 				clocks = <&udc_clk>, <&udpck>;
-- 
1.9.1
