From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 16:49:49 +0200
Subject: [PATCH 4/4] ARM: dts: omap3-overo: Add default trigger for TWL4030 LED
In-Reply-To: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370962189-9689-5-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c971ff1 'leds: leds-pwm: Defer led_pwm_set() if PWM can sleep'
fixed a crash when using a trigger with a pwm-led provided by an
external chip. Now it is safe to add the default trigger according
to board-overo.c.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index e112a42..0bcc284 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -21,6 +21,7 @@
 			label = "overo:blue:COM";
 			pwms = <&twl_pwmled 1 7812500>;
 			max-brightness = <127>;
+			linux,default-trigger = "mmc0";
 		};
 	};
 
-- 
1.7.5.4
