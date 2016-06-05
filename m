From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 14:23:11 +0200
Subject: [PATCH 1/3] ARM: dts: sun4i: The blue led on the Mele A1000 is a
 power led
Message-ID: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The blue led on the Mele A1000 is wired to light up as soon as the board
has powered (it will be on while the gpio is still in input / floating
mode), also its location on the top-set box clearly signals "power led".

Until now we've been treating this as a generic usr function led, which
means that when you plug power into the top-set box, the power-led lights
and then turns off as soon as the kernel loads, which looks wrong.

This renames the led from a1000:blue:usr to a1000:blue:pwr and marks
it as default on, fixing this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index fa70b8f..39e368e 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -72,8 +72,9 @@
 		};
 
 		blue {
-			label = "a1000:blue:usr";
+			label = "a1000:blue:pwr";
 			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
 	};
 
-- 
2.7.4
