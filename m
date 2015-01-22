From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:16 +0100
Subject: [PATCH 10/13] ARM: dts: omap3-gta04: add gyroscope
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-11-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ab5dd98..08f0b25 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -240,6 +240,14 @@
 		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
 
+	/* gyroscope */
+	itg3200 at 68 {
+		compatible = "invensense,itg3200";
+		reg = <0x68>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <24 0>; /* GPIO_56 */
+	};
+
 	/* leds */
 	tca6507 at 45 {
 		compatible = "ti,tca6507";
-- 
1.9.1
