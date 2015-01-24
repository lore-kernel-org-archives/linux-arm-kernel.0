From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Jan 2015 22:33:48 +0800
Subject: [PATCH 2/2] ARM: dts: sun6i: Add resistive touchscreen controller
 node to dtsi
In-Reply-To: <1422110028-30270-1-git-send-email-wens@csie.org>
References: <1422110028-30270-1-git-send-email-wens@csie.org>
Message-ID: <1422110028-30270-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we support the sun6i variant of the touchscreen controller,
add the device node to the dtsi so we can use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 188f59e558bc..ec70454b0add 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -664,6 +664,13 @@
 			reg = <0x01c20ca0 0x20>;
 		};
 
+		rtp: rtp at 01c25000 {
+			compatible = "allwinner,sun6i-a31-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.1.4
