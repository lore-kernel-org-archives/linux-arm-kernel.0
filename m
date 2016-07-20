From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 16:11:39 +0200
Subject: [PATCH v2 4/4] ARM: sun5i: chip: Add status LED
In-Reply-To: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
References: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720141139.25098-5-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CHIP has a status LED connected to one of the AXP GPIOs. Add the
gpio-leds node to be able to use the proper LED framework to control it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index f694482bdeb6..b68a12374b35 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -64,6 +64,16 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status {
+			label = "chip:white:status";
+			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
 };
 
 &be0 {
-- 
2.9.0
