From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 23 Jan 2013 18:56:51 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the on-board LED connected to the TWL4030 (LEDB) to use
pwm-leds.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 89808ce..800be29 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -14,12 +14,13 @@
 /include/ "omap3.dtsi"
 
 / {
-	leds {
-		compatible = "gpio-leds";
+	pwmleds {
+		compatible = "pwm-leds";
+
 		overo {
 			label = "overo:blue:COM";
-			gpios = <&twl_gpio 19 0>;
-			linux,default-trigger = "mmc0";
+			pwms = <&twl_pwmled 1 7812500>;
+			max-brightness = <127>;
 		};
 	};
 };
-- 
1.7.5.4
