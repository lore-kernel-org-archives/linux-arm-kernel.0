From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:35 +0200
Subject: [PATCH 55/71] dts: ca5: add the global timer for the A5
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-55-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew.leach@arm.com>

The Cortex A5 contains a global timer: add the appropriate device tree
node.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index c544a55..d2709b7 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -88,6 +88,14 @@
 		interrupts = <1 13 0x304>;
 	};
 
+	timer at 2c000200 {
+		compatible = "arm,cortex-a5-global-timer",
+		             "arm,cortex-a9-global-timer";
+		reg = <0x2c000200 0x20>;
+		interrupts = <1 11 0x304>;
+		clocks = <&oscclk0>;
+	};
+
 	watchdog at 2c000620 {
 		compatible = "arm,cortex-a5-twd-wdt";
 		reg = <0x2c000620 0x20>;
@@ -120,7 +128,7 @@
 		compatible = "arm,vexpress,config-bus";
 		arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-		osc at 0 {
+		oscclk0: osc at 0 {
 			/* CPU and internal AXI reference clock */
 			compatible = "arm,vexpress-osc";
 			arm,vexpress-sysreg,func = <1 0>;
-- 
1.7.9.5
