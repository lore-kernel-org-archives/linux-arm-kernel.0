From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Jan 2013 18:32:45 +0100
Subject: [PATCH v2 5/5] clocksource: update and move armada-370-xp-timer
 documentation to timer directory
In-Reply-To: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
References: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1359135165-32108-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer driver for Armada 370 and Armada XP have gained local timers
support. So it needs new resources information regarding the IRQs
and the registers.

Also move the documentation in the new and more accurate directory

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../bindings/arm/armada-370-xp-timer.txt           |   12 ------------
 .../bindings/timer/marvell,armada-370-xp-timer.txt |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
deleted file mode 100644
index 6483011..0000000
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Marvell Armada 370 and Armada XP Global Timers
-----------------------------------------------
-
-Required properties:
-- compatible: Should be "marvell,armada-370-xp-timer"
-- interrupts: Should contain the list of Global Timer interrupts
-- reg: Should contain the base address of the Global Timer registers
-- clocks: clock driving the timer hardware
-
-Optional properties:
-- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
-  Mhz fixed mode (available on Armada XP and not on Armada 370)
diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
new file mode 100644
index 0000000..3638112
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
@@ -0,0 +1,15 @@
+Marvell Armada 370 and Armada XP Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "marvell,armada-370-xp-timer"
+- interrupts: Should contain the list of Global Timer interrupts and
+  then local timer interrupts
+- reg: Should contain location and length for timers register. First
+  pair for the Global Timer registers, second pair for the
+  local/private timers.
+- clocks: clock driving the timer hardware
+
+Optional properties:
+- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
+  Mhz fixed mode (available on Armada XP and not on Armada 370)
-- 
1.7.9.5
