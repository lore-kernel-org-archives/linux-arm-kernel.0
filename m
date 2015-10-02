From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  2 Oct 2015 16:59:49 +0200
Subject: [PATCH v7 4/5] ARM: berlin: add a PWM node on the BG2
In-Reply-To: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1443797990-10809-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PWM node in the Berlin BG2 device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ef811de09908..f094b06d16aa 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -404,6 +404,13 @@
 			};
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
