From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  2 Oct 2015 16:59:50 +0200
Subject: [PATCH v7 5/5] ARM: berlin: add a PWM node on the BG2CD
In-Reply-To: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1443797990-10809-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PWM node in the Berlin BG2CD device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d78a32..5d984f58dde7 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -368,6 +368,13 @@
 			status = "disabled";
 		};
 
+		pwm: pwm at f20000 {
+			compatible = "marvell,berlin-pwm";
+			reg = <0xf20000 0x40>;
+			clocks = <&chip_clk CLKID_CFG>;
+			#pwm-cells = <3>;
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.6.0
