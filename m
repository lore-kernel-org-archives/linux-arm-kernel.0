From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 15:01:09 +0200
Subject: [PATCH 1/5] ARM: at91: at91sam9x5 RTC is not compatible with
 at91rm9200 one
In-Reply-To: <cover.1366289869.git.nicolas.ferre@atmel.com>
References: <cover.1366289869.git.nicolas.ferre@atmel.com>
Message-ID: <864f10566b35864d469f6ff2913b9afaa0c69350.1366289869.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a bug with RTC IMR, we cannot consider at91sam9x5 RTC compatible
with the previous one. Modify DT compatibility string, even if the driver
is not yet modified to take it into account.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a3d4464..58747f3 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -564,7 +564,7 @@
 			};
 
 			rtc at fffffeb0 {
-				compatible = "atmel,at91rm9200-rtc";
+				compatible = "atmel,at91sam9x5-rtc";
 				reg = <0xfffffeb0 0x40>;
 				interrupts = <1 4 7>;
 				status = "disabled";
-- 
1.8.0
