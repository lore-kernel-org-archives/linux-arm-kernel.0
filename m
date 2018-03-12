From: harald@ccbib.org (Harald Geyer)
Date: Mon, 12 Mar 2018 16:10:49 +0000
Subject: [PATCH 4/5] arm64: dts: allwinner: a64: Add pwm device
In-Reply-To: <20180312161050.7647-1-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
Message-ID: <20180312161050.7647-5-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device is compatible with A13, so no new driver is needed.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
I saw that Andre Przywara has been working on A64 pwm too and has
submitted some patches a few days ago. I think his patches are functionally
equivalent to this one here, but clean up things a bit and thus are
preferable. See:

https://groups.google.com/forum/#!topic/linux-sunxi/hQFeteP591k

I'm including my patch here mostly to have a consistent series for others
to test. OTOH you might merge the device tree changes here and pick up
the cleanup patches from him. Either way should work fine.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 05d5e8def68a..95d52f6aa07f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -364,6 +364,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm_pin {
+				pins = "PD22";
+				function = "pwm";
+			};
+
 			rmii_pins: rmii_pins {
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
@@ -629,6 +634,14 @@
 			#interrupt-cells = <3>;
 		};
 
+		pwm: pwm at 1c21400 {
+			compatible = "allwinner,sun5i-a13-pwm";
+			reg = <0x01c21400 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc: rtc at 1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.11.0
