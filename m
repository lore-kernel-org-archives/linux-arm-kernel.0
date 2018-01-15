From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Jan 2018 15:14:46 +0800
Subject: [PATCH v3 4/8] ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
In-Reply-To: <20180115071450.18355-1-wens@csie.org>
References: <20180115071450.18355-1-wens@csie.org>
Message-ID: <20180115071450.18355-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM is a collection of clock controls, reset controls, and various
power switches/gates. Some of these can be independently listed and
supported, while a number of CPU related ones are used in tandem with
CPUCFG for SMP bringup and CPU hotplugging.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 85ecb4d64cfd..bf4d40e8359f 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -709,6 +709,11 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		prcm at 8001400 {
+			compatible = "allwinner,sun9i-a80-prcm";
+			reg = <0x08001400 0x200>;
+		};
+
 		apbs_rst: reset at 80014b0 {
 			reg = <0x080014b0 0x4>;
 			compatible = "allwinner,sun6i-a31-clock-reset";
-- 
2.15.1
