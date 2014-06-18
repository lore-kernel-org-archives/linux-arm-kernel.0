From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 10:43:19 -0500
Subject: [PATCH v2 1/2] arm: dts: am4372: let boards enable RTC and Watchdog
In-Reply-To: <1403106200-777-1-git-send-email-balbi@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
Message-ID: <1403106200-777-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by providing phandles to rtc and wdt nodes, we can
let boards enable rtc and wdt as necessary.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..e3830d4 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -270,7 +270,7 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		rtc at 44e3e000 {
+		rtc: rtc at 44e3e000 {
 			compatible = "ti,am4372-rtc","ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
@@ -279,7 +279,7 @@
 			status = "disabled";
 		};
 
-		wdt at 44e35000 {
+		wdt: wdt@44e35000 {
 			compatible = "ti,am4372-wdt","ti,omap3-wdt";
 			reg = <0x44e35000 0x1000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.0.0.rc1
