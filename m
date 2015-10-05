From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  5 Oct 2015 16:23:08 +0200
Subject: [PATCH v2 3/5] ARM: sun5i: dt: Move uart3 pinctrl node to common DTSI
In-Reply-To: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1444054990-15946-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart3 pins are shared between the A10s and A13, move the pinctrl node
to the common DTSI to avoid duplication.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 -------
 arch/arm/boot/dts/sun5i.dtsi      | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0fdabe8eb9e8..2ebd32f5bc6e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -204,13 +204,6 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	uart3_pins_a: uart3 at 0 {
-		allwinner,pins = "PG9", "PG10";
-		allwinner,function = "uart3";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
 	emac_pins_a: emac0 at 0 {
 		allwinner,pins = "PA0", "PA1", "PA2",
 				"PA3", "PA4", "PA5", "PA6",
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 78b993abbaa3..433c83a321ca 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -529,6 +529,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
+
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PG9", "PG10";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.5.3
