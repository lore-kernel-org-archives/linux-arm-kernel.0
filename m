From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 18:04:02 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i-a33: Add pinmux setting for uart0 on PB
 pins
In-Reply-To: <1433239443-738-1-git-send-email-wens@csie.org>
References: <1433239443-738-1-git-send-email-wens@csie.org>
Message-ID: <1433239443-738-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 adds an additional pinmux option for uart0 on the PB pins.
This was not present on the A23. Nor is it available on the H3,
which does not have the PB pingroup.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 9b43bc6e7926..85ee08098b7b 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -86,4 +86,12 @@
 	compatible = "allwinner,sun8i-a33-pinctrl";
 	interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+
+	uart0_pins_b: uart0 at 1 {
+		allwinner,pins = "PB0", "PB1";
+		allwinner,function = "uart0";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 };
-- 
2.1.4
