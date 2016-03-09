From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 Mar 2016 11:50:14 +0100
Subject: [PATCH 4/4] ARM: sun5i: chip: Add status LED
In-Reply-To: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1457520614-32239-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CHIP has a status LED connected to one of the AXP GPIOs. Add the
gpio-leds node to be able to use the proper LED framework to control it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index f6898c6b84d4..9a54df81ece7 100644
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
 
 &codec {
-- 
2.7.2
