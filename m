From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 14:26:51 +0100
Subject: [PATCHv2 2/2] dts: AT91 Watchdog, remove property idle halt by default
In-Reply-To: <1421587611-32708-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118090820.07856398@bbrezillon>
 <1421587611-32708-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421587611-32708-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The behavior changed when watchdog properties were added to DT, it makes
the watchdog not counting when CPU is in idle state, therefore the
watchdog reset time depends on mean CPU usage and will not reset at all
if the CPU stop working while it is in idle state, which is a very weird
behavior.

Apply principle of least surprise on at91sam9260-wdt by removing idle
halt flag by default.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
 arch/arm/boot/dts/at91sam9260.dtsi | 1 -
 arch/arm/boot/dts/at91sam9263.dtsi | 1 -
 arch/arm/boot/dts/at91sam9g45.dtsi | 1 -
 arch/arm/boot/dts/at91sam9n12.dtsi | 1 -
 arch/arm/boot/dts/at91sam9x5.dtsi  | 1 -
 arch/arm/boot/dts/sama5d3.dtsi     | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index dd1313c..184e1d1 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -971,7 +971,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 1467750..c39556b 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -874,7 +874,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2a8da8a..b8d741d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1111,7 +1111,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 68eb9ad..e0b5c24 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -889,7 +889,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
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
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..63d12ed 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1224,7 +1224,6 @@
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
-				atmel,idle-halt;
 				status = "disabled";
 			};
 
-- 
2.1.4
