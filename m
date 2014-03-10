From: matthew.leach@arm.com (Matthew Leach)
Date: Mon, 10 Mar 2014 11:51:33 +0000
Subject: [PATCH 3/4] dts: ca5: add the global timer for the A5
In-Reply-To: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
References: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1394452294-24552-4-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex A5 contains a global timer: add the appropriate device tree
node.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts | 10 +++++++++-
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
1.8.5.3
