From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 14:26:50 +0100
Subject: [PATCHv2 1/2] dts: Documentation: AT91 Watchdog, explain what atmel,
 idle-halt property really do
In-Reply-To: <1421587611-32708-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118090820.07856398@bbrezillon>
 <1421587611-32708-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421587611-32708-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel,idle-halt property should be used with care, it actually makes the
watchdog not counting when the CPU is in idle state, therefore the
watchdog reset time depends on mean CPU usage and will not reset at all
of the CPU stop working while it is in idle state, which is probably not
what you want.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index f90e294..a4d8697 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -26,6 +26,11 @@ Optional properties:
 - atmel,disable : Should be present if you want to disable the watchdog.
 - atmel,idle-halt : Should be present if you want to stop the watchdog when
 	entering idle state.
+	CAUTION: This property should be used with care, it actually makes the
+	watchdog not counting when the CPU is in idle state, therefore the
+	watchdog reset time depends on mean CPU usage and will not reset at all
+	if the CPU stop working while it is in idle state, which is probably
+	not what you want.
 - atmel,dbg-halt : Should be present if you want to stop the watchdog when
 	entering debug state.
 
-- 
2.1.4
