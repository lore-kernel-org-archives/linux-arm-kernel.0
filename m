From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 19 Aug 2013 13:28:15 -0300
Subject: [PATCH 4/4] clocksource: armada-370-xp: Fix clock input in devicetree
 binding
Message-ID: <1376929695-10026-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit specifies the clock inputs available for the Armada XP
timer: namely the 'nbclk' (L2/coherency fabric) and the 'refclk'
(25 MHz fixed-clock).

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/timer/marvell,armada-370-xp-timer.txt        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
index 4c453b2..8e719a1 100644
--- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
@@ -9,8 +9,7 @@ Required properties:
 - reg: Should contain location and length for timers register. First
   pair for the Global Timer registers, second pair for the
   local/private timers.
-- clocks: clock driving the timer hardware, only required for
-  "marvell,armada-370-timer";
+- clocks: clock driving the timer hardware.
 
 Examples:
 
@@ -29,4 +28,6 @@ Examples:
 		compatible = "marvell,armada-xp-timer";
 		reg = <0x20300 0x30>, <0x21040 0x30>;
 		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
+		clocks = <&coreclk 2>, <&refclk>;
+		clock-names = "nbclk", "fixed";
 	};
-- 
1.8.1.5
