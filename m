From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Mar 2014 15:18:04 -0300
Subject: [PATCH v4 9/9] ARM: mvebu: Add A375/A380 watchdog binding
 documentation
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394907484-26002-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit documents the new support for "marvell,armada-{375,380}-wdt"
compatible strings and the extra 'reg' entry requirement.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index de11eb4..97223fd 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -5,11 +5,18 @@ Required Properties:
 - Compatibility : "marvell,orion-wdt"
 		  "marvell,armada-370-wdt"
 		  "marvell,armada-xp-wdt"
+		  "marvell,armada-375-wdt"
+		  "marvell,armada-380-wdt"
 
 - reg		: Should contain two entries: first one with the
 		  timer control address, second one with the
 		  rstout enable address.
 
+For "marvell,armada-375-wdt" and "marvell,armada-380-wdt":
+
+- reg		: A third entry is mandatory and should contain the
+                  shared mask/unmask RSTOUT address.
+
 Optional properties:
 
 - interrupts	: Contains the IRQ for watchdog expiration
-- 
1.9.0
