From: dianders@chromium.org (Douglas Anderson)
Date: Thu,  1 Sep 2016 16:53:22 -0700
Subject: [PATCH] arm64: dts: rockchip: Add pinctrl entry for 32k clock on
 rk3399
Message-ID: <1472774002-25986-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some rk3399 boards GPIO0_A0 is hooked up to a 32 kHz clock.  This can
be used as the source for various clocks in the system.

Add a pinmux so boards can get this pin properly configured.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 62d450935a57..13e2a440fe43 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1171,6 +1171,12 @@
 			drive-strength = <13>;
 		};
 
+		clock {
+			clk_32k: clk-32k {
+				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins =
-- 
2.8.0.rc3.226.g39d4020
