From: dbasehore@chromium.org (Derek Basehore)
Date: Thu, 15 Nov 2018 21:17:19 -0800
Subject: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
Message-ID: <20181116051719.23376-1-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the xin32k clock to the RK3399 CPU. Even though it's not
directly used, muxes will end up traversing the entire clk tree on
calls to determine_rate if it doesn't exist.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 99e7f65c1779..3d09472978f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -191,6 +191,13 @@
 		#clock-cells = <0>;
 	};
 
+	ap_rtc_clk: ap-rtc-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.19.1.1215.g8438c0b245-goog
