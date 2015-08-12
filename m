From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 14:56:54 -0500
Subject: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU nodes
In-Reply-To: <1439409416-32673-1-git-send-email-balbi@ti.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
Message-ID: <1439409416-32673-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x devices sport SCU, TWD and Global timers,
let's add them to DTS so they have a chance to
probe and be used by Linux.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 51feccfa0e0a..7dfc9d8bd003 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,6 +64,27 @@
 		interrupt-parent = <&gic>;
 	};
 
+	scu: scu at 48240000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x48240000 0x100>;
+	};
+
+	global_timer: timer at 48240200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x48240200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	local_timer: timer at 48240600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x48240600 0x100>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
 	l2-cache-controller at 48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
-- 
2.5.0
