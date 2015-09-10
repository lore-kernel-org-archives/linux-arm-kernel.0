From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 10 Sep 2015 15:05:58 +0200
Subject: [PATCH 1/2] ARM: dts: sun5i: Add emac_pins_b definition
Message-ID: <1441890359-4675-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jelle van der Waa <jelle@vdwaa.nl>

The emac pins on an A10s can also be routed to the outside through
PORTD rather then through PORTA, add a pinctrl node for this.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 6ff2139..45ca0c5 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -215,6 +215,17 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	emac_pins_b: emac0 at 1 {
+		allwinner,pins = "PD6", "PD7", "PD10",
+				"PD11", "PD12", "PD13", "PD14",
+				"PD15", "PD18", "PD19", "PD20",
+				"PD21", "PD22", "PD23", "PD24",
+				"PD25", "PD26", "PD27";
+		allwinner,function = "emac";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc1_pins_a: mmc1 at 0 {
 		allwinner,pins = "PG3", "PG4", "PG5",
 				 "PG6", "PG7", "PG8";
-- 
2.4.3
