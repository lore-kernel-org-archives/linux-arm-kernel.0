From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Oct 2013 14:07:41 +0100
Subject: [PATCH v2 3/5] ARM: sun5i: a10s: Add support for the High Speed Timers
In-Reply-To: <1382706463-3892-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1382706463-3892-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1382706463-3892-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10s has support for two high speed timers. Now that we
have a driver to support it, we can enable them in the device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 5247674..e674c94 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -332,5 +332,12 @@
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
+
+		timer at 01c60000 {
+			compatible = "allwinner,sun5i-a13-hstimer";
+			reg = <0x01c60000 0x1000>;
+			interrupts = <82>, <83>;
+			clocks = <&ahb_gates 28>;
+		};
 	};
 };
-- 
1.8.4
