From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 14:41:40 +0800
Subject: [PATCH 2/3] arm: dts: berlin2q: enable all wdt nodes unconditionally
In-Reply-To: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
References: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
Message-ID: <1467787301-3728-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit f29a72c24ad4 ("watchdog: dw_wdt: Convert to use watchdog
infrastructure"), the dw_wdt driver can support multiple variants, so
unconditionally enable all dw_wdt nodes now.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 2c34bfb..7e61d04 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -525,7 +525,6 @@
 				reg = <0x2000 0x100>;
 				clocks = <&refclk>;
 				interrupts = <1>;
-				status = "disabled";
 			};
 
 			wdt2: watchdog at 3000 {
@@ -533,7 +532,6 @@
 				reg = <0x3000 0x100>;
 				clocks = <&refclk>;
 				interrupts = <2>;
-				status = "disabled";
 			};
 
 			sm_gpio1: gpio at 5000 {
-- 
2.8.1
