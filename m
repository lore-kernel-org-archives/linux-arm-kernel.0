From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:58 -0300
Subject: [PATCH 7/7] watchdog: orion: Update device-tree binding documentation
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377182518-12554-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the 'reg' property meaning, by defining three required cells.
It's important to note this commit breaks DT-compatibility for this
device.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
index 5dc8d30..bb7f1a2 100644
--- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
@@ -3,7 +3,10 @@
 Required Properties:
 
 - Compatibility : "marvell,orion-wdt"
-- reg		: Address of the timer registers
+- reg		: Three cells are required.
+		  First  cell contains the global timer control register.
+		  Second cell contains the watchdog counter register.
+		  Third  cell contains the RSTOUT register.
 
 Optional properties:
 
@@ -13,7 +16,9 @@ Example:
 
 	wdt at 20300 {
 		compatible = "marvell,orion-wdt";
-		reg = <0x20300 0x28>;
+		reg = <0x20300 0x4
+		       0x20324 0x4
+		       0x20108 0x4>;
 		timeout-sec = <10>;
 		status = "okay";
 	};
-- 
1.8.1.5
