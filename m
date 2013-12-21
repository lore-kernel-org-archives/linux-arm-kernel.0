From: marek@goldelico.com (Marek Belisko)
Date: Sat, 21 Dec 2013 16:12:23 +0100
Subject: [PATCH] ARM: dts: omap3-gta04: Add EOC irq gpio line handling.
Message-ID: <1387638743-12278-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BMP085 EOC (End Of Conversion) irq line is connected to
gpio113 on gta04. Set irq properties to have driver using irq
instead polling for EOC.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index b9b55c9..7a8e37d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -92,6 +92,8 @@
 	bmp085 at 77 {
 		compatible = "bosch,bmp085";
 		reg = <0x77>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
 	};
 
 	/* leds */
-- 
1.8.4.2
