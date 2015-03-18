From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Mar 2015 16:00:28 +0800
Subject: [PATCH] ARM: dts: sun9i: Enable ARM architected timer on A80
Message-ID: <1426665628-32014-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 SoC has the architected timer, but the existing firmware from
Allwinner does not set CNTFRQ at all.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I'm not so sure about the cpu mask, but there's no SMP
support to actually test it.

---
 arch/arm/boot/dts/sun9i-a80.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 2f7f82cc86ba..d46c0c70101c 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -114,6 +114,16 @@
 		reg = <0 0x20000000 0x02 0>;
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.4
