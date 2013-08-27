From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:37 -0300
Subject: [PATCH 13/15] watchdog: orion: Add other compatibles to devicetree
 binding
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the newly supported compatible-strings for Armada 370 and Armada
XP SoC. In addition, specify the required clock inputs for each supported
compatible:
 * orion-wdt and armada-370 requires a single clock phandle
 * armada-xp requires two clock phandles with clock-names "nbclk" and "fixed".

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/orion-wdt.txt          | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
index 5dc8d30..a6e6602 100644
--- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
@@ -2,9 +2,23 @@
 
 Required Properties:
 
-- Compatibility : "marvell,orion-wdt"
+- Compatibility : "marvell,orion-wdt",
+		  "marvell,armada-370-wdt"
+		  "marvell,armada-xp-wdt"
 - reg		: Address of the timer registers
 
+Clocks required for compatibles = "marvell,orion-wdt",
+				  "marvell,armada-370-wdt"
+
+- clocks	: Must contain a single entry describing
+		  the clock input.
+
+Clocks required for compatible = "marvell,armada-xp-wdt":
+- clocks	: Must contain an entry for each entry in clock-names.
+- clock-names	: Must include the following entries:
+		  "nbclk" (L2/coherency fabric clock),
+		  "fixed" (Reference 25 MHz fixed-clock).
+
 Optional properties:
 
 - timeout-sec	: Contains the watchdog timeout in seconds
@@ -16,4 +30,5 @@ Example:
 		reg = <0x20300 0x28>;
 		timeout-sec = <10>;
 		status = "okay";
+		clocks = <&gate_clk 7>;
 	};
-- 
1.8.1.5
