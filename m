From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 01:31:19 +0200
Subject: [PATCH] ARM: dts: at91: ma5d4: properly define crystals frequencies
Message-ID: <1465342279-9193-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Denx MA5D4 dts doesn't properly define the slow_xtal and main_xtal
frequencies, the PMC then has to fallback to using the RC oscillators whose
precision is not really good.

As both crystals are populated, define their frequencies, see p17 of
http://www.denx-cs.de/sites/all/files/MA5D4.HWM_.002.pdf

Also, remove the obsolete main_clock definition.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index e7b2109fc85a..99d57131782f 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -20,8 +20,11 @@
 	};
 
 	clocks {
-		main_clock: main_clock {
-			compatible = "atmel,osc", "fixed-clock";
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
 			clock-frequency = <12000000>;
 		};
 
-- 
2.8.1
