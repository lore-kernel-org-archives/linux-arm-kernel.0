From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 00:24:56 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i: Add watchdog device node for A83T
In-Reply-To: <1452961497-10804-1-git-send-email-wens@csie.org>
References: <1452961497-10804-1-git-send-email-wens@csie.org>
Message-ID: <1452961497-10804-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T, like previous Allwinner SoCs, has a watchdog as part of its
timer block. Add a device node for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 08df5598df9c..8d27b6381257 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -182,6 +182,13 @@
 			clocks = <&osc24M>;
 		};
 
+		watchdog at 01c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.0.rc3
