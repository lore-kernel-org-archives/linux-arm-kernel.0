From: samuel@sholland.org (Samuel Holland)
Date: Wed, 11 Jul 2018 21:25:15 -0500
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Enable A64 timer workaround
In-Reply-To: <20180712022515.7255-1-samuel@sholland.org>
References: <20180712022515.7255-1-samuel@sholland.org>
Message-ID: <20180712022515.7255-3-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As instability in the architectural timer has been observed on multiple
devices using this SoC, inluding the Pine64 and the Orange Pi Win,
enable the workaround in the SoC's device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..5202b76e9684 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -152,6 +152,7 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
+		allwinner,sun50i-a64-unstable-timer;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14
-- 
2.16.1
