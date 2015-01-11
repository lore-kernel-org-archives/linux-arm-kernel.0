From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Jan 2015 20:33:44 +0100
Subject: [PATCH] ARM: sun6i: Enable ARM arch timers
Message-ID: <1421004824-17525-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has non-initialized architected timers, without CNTFRQ or CNTVOFF set
by the Allwinner's bootloader.

Use the new DT property for such case, and enable the arch timers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 69e5401df662..a0d1fe2c9c3a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -79,6 +79,16 @@
 		};
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
 	cpus {
 		enable-method = "allwinner,sun6i-a31";
 		#address-cells = <1>;
-- 
2.2.1
