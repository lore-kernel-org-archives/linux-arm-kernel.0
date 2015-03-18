From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Mar 2015 11:24:00 +0800
Subject: [PATCH 1/3] ARM: dts: sun8i: Enable ARM architected timer on A23
In-Reply-To: <1426649042-30547-1-git-send-email-wens@csie.org>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
Message-ID: <1426649042-30547-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23 SoC has the architected timer, but the existing firmware from
Allwinner does not set CNTFRQ at all.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 674d4c5e7ee1..78440dffd678 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -70,6 +70,16 @@
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
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.4
