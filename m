From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Mar 2013 19:00:55 +0530
Subject: [PATCH v2 09/11] ARM: dts: OMAP5: Add watchdog timer node
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1363699857-5505-10-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Add watchdog timer dt node for OMAP5 devices.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 59e05c5..f4c71d9 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -590,6 +590,13 @@
 			ti,timer-pwm;
 		};
 
+		wdt2: wdt at 4ae14000 {
+			compatible = "ti,omap5-wdt", "ti,omap3-wdt";
+			reg = <0x4ae14000 0x80>;
+			interrupts = <0 80 0x4>;
+			ti,hwmods = "wd_timer2";
+		};
+
 		emif1: emif at 0x4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
-- 
1.7.9.5
