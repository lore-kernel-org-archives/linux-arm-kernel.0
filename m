From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 7 Sep 2012 10:55:18 +0200
Subject: [PATCH] ARM: dts: omap3-beagle: Add heartbeat and mmc LEDs support
Message-ID: <5049B676.1080004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support for D6 and D7 LEDs on Beagle board.
- D6 will be used for heartbeat
- D7 will be used for mmc0

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

It is based on top of the LEDB support added by Florian.

Regards,
Benoit

 arch/arm/boot/dts/omap3-beagle.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3fe35c2..ca46fb2 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -24,6 +24,18 @@
 			label = "beagleboard::pmu_stat";
 			gpios = <&twl_gpio 19 0>; /* LEDB */
 		};
+
+		heartbeat {
+			label = "beagleboard::usr0";
+			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			linux,default-trigger = "heartbeat";
+		};
+
+		mmc {
+			label = "beagleboard::usr1";
+			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			linux,default-trigger = "mmc0";
+		};
 	};
 };
 
-- 
1.7.0.4
