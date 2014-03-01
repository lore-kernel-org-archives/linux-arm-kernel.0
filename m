From: marek@goldelico.com (Marek Belisko)
Date: Sat,  1 Mar 2014 14:58:54 +0100
Subject: [PATCH v2 7/7] ARM: dts: omap3-gta04: Add bma180 accelerometer
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <1393682334-26805-8-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

Add node for bma180 driver.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d556e3a..f8ad125 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -110,6 +110,14 @@
 		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
 	};
 
+	/* accelerometer */
+	bma180 at 41 {
+		compatible = "bosch,bma180";
+		reg = <0x41>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	/* leds */
 	tca6507 at 45 {
 		compatible = "ti,tca6507";
-- 
1.8.3.2
