From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:19:06 -0200
Subject: [PATCH 12/13] ARM: dts: rv1108: Pass the 'arm,
 cpu-registers-not-fw-configured' property
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-12-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since firmware does not initialize  any of the generic timer CPU
registers pass the 'arm,cpu-registers-not-fw-configured' property as
suggested in Documentation/devicetree/bindings/timer/arm,arch_timer.txt.

This also aligns with other Rockchip SoC dtsi files.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 42566adadc83..d96c58728b28 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -71,6 +71,7 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
+		arm,cpu-registers-not-fw-configured;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
-- 
2.19.1
