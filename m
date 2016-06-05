From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 14:23:12 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: The blue led on the Mele A1000G quad is
 a power led
In-Reply-To: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
References: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465129393-22379-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The blue led on the Mele A1000 is wired to light up as soon as the board
has powered (it will be on while the gpio is still in input / floating
mode), also its location on the top-set box clearly signals "power led".

Until now we've been treating this as a generic usr function led, which
means that when you plug power into the top-set box, the power-led lights
and then turns off as soon as the kernel loads, which looks wrong.

This renames the led from m9:blue:usr to a1000g:blue:pwr (fixing a copy
and paste error in the prefix while at it) and marks it as default on,
fixing this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 4dd70cc..e063dab 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -65,8 +65,9 @@
 		pinctrl-0 = <&led_pins_m9>;
 
 		blue {
-			label = "m9:blue:usr";
+			label = "a1000g:blue:pwr";
 			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
 	};
 };
-- 
2.7.4
