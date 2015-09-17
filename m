From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 17 Sep 2015 12:13:06 +0200
Subject: [PATCH v6 3/5] ARM: berlin: add a PWM node on the BG2Q
In-Reply-To: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1442484788-15482-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PWM node in the Berlin BG2Q device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a48490e2f9..5bfa71a87617 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -477,6 +477,13 @@
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
2.5.2
