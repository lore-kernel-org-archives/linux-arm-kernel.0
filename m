From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 22:49:56 +0100
Subject: [PATCH] AT91: DT: Watchdog, remove property idle halt by default
Message-ID: <1421531396-20188-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The behavior changed when watchdog properties were added to DT, it makes
the watchdog not counting when CPU is in idle state, therefore the
watchdog reset time depend on mean CPU usage and will not reset at all
if the CPU stop working while it is in idle state, which is a very weird
behavior.

Apply principle of least surprise on at91sam9260-wdt by removing idle
halt flag by default.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index bbb3ba6..ce61f91 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1125,7 +1125,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
-- 
2.1.4
