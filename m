From: marek@goldelico.com (Marek Belisko)
Date: Wed,  4 Feb 2015 23:14:33 +0100
Subject: [PATCH v3 4/6] ARM: dts: omap3-gta04: Add battery support
In-Reply-To: <1423088075-10025-1-git-send-email-marek@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Message-ID: <1423088075-10025-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 655d6e9..f81ca27 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -49,6 +49,32 @@
 		ti,codec = <&twl_audio>;
 	};
 
+	battery {
+		compatible = "ti,twl4030-madc-battery";
+		capacity-uah = <1200000>;
+		volt-to-capacity-charging-map = <4200 100>,
+					     <4100 75>,
+					     <4000 55>,
+					     <3900 25>,
+					     <3800 5>,
+					     <3700 2>,
+					     <3600 1>,
+					     <3300 0>;
+		volt-to-capacity-discharging-map = <4200 100>,
+						<4100 95>,
+						<4000 70>,
+						<3800 50>,
+						<3700 10>,
+						<3600 5>,
+						<3300 0>;
+		io-channels = <&twl_madc 1>,
+	                      <&twl_madc 10>,
+			      <&twl_madc 12>;
+		io-channel-names = "temp",
+		                   "ichg",
+		                   "vbat";
+	};
+
 	spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
@@ -449,3 +475,7 @@
 		};
 	};
 };
+
+&twl_madc {
+	ti,system-uses-second-madc-irq;
+};
-- 
1.9.1
