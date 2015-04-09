From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Apr 2015 10:59:26 -0500
Subject: [PATCH 1/2] arm: boot: dts: am437x-sk: fix for new newhaven display
 module revision
Message-ID: <1428595167-10050-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x Starter Kit uses a NewHaven Display module with
a 4.3" display and EDT FT5306 touchscreen

On that module's new revision, NewHave decided to change
the pinout on the 6 pin flat-pcb touchscreen connector so
that instead of having WAKE pin, we now have RESETn.

The new display module is available on AM437x SK Beta and
all new revisions while the older revision is only available
on AM437x SK Alpha which, unfortunately, can't be supported
anymore in mainline without a revert of this patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 832d24318f62..58dc1cd58bdd 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -474,7 +474,7 @@
 		interrupt-parent = <&gpio0>;
 		interrupts = <31 0>;
 
-		wake-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <272>;
-- 
2.3.0
