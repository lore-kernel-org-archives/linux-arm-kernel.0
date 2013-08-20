From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 09:36:29 -0300
Subject: [PATCH v2 4/4] clocksource: armada-370-xp: Add detailed clock
 requirements in devicetree binding
In-Reply-To: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377002189-4398-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifies the required clock inputs for each supported compatible.
Armada 370 requires a single clock phandle, and Armada XP requires
two clock phandles with clock-names "nbclk" and "fixed".

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../bindings/timer/marvell,armada-370-xp-timer.txt          | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
index 4c453b2..f455182 100644
--- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
@@ -9,8 +9,15 @@ Required properties:
 - reg: Should contain location and length for timers register. First
   pair for the Global Timer registers, second pair for the
   local/private timers.
-- clocks: clock driving the timer hardware, only required for
-  "marvell,armada-370-timer";
+
+Clocks required for compatible = "marvell,armada-370-timer":
+- clocks : Must contain a single entry describing the clock input
+
+Clocks required for compatible = "marvell,armada-xp-timer":
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "nbclk" (L2/coherency fabric clock),
+  "fixed" (Reference 25 MHz fixed-clock).
 
 Examples:
 
@@ -29,4 +36,6 @@ Examples:
 		compatible = "marvell,armada-xp-timer";
 		reg = <0x20300 0x30>, <0x21040 0x30>;
 		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
+		clocks = <&coreclk 2>, <&refclk>;
+		clock-names = "nbclk", "fixed";
 	};
-- 
1.8.1.5
