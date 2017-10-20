From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:10 +0200
Subject: [PATCH 07/31] arm64: dts: renesas: r8a77995: draak: enable PWM
 channel 0 and 1
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <b35334447513c14a4dd55a67c269a743d4a4824b.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables PWM channel 0 and 1 on the draak. Each channel
connects to LTC2644 for brightness control.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index fac58be83383..09de73b11db8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -46,6 +46,16 @@
 		};
 	};
 
+	pwm0_pins: pwm0 {
+		groups = "pwm0_c";
+		function = "pwm0";
+	};
+
+	pwm1_pins: pwm1 {
+		groups = "pwm1_c";
+		function = "pwm1";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data";
 		function = "scif2";
@@ -94,6 +104,20 @@
 	status = "okay";
 };
 
+&pwm0 {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.11.0
