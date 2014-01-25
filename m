From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:28:56 +0100
Subject: [PATCH 2/9] ARM: dts: omap3-gta04: Add bma180 accelerometer.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 9d37184..e315675 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -94,6 +94,14 @@
 		reg = <0x77>;
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
