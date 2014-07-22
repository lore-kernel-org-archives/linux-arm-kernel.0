From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Jul 2014 21:30:16 +0200
Subject: [PATCH v2 3/7] arm: dts: omap3-gta04: Add wifi reset node
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <1406057420-22269-4-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define gpio node in tca6507 which will be used as
wifi reset pin.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 6d1a8d8..5b08d93 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -196,6 +196,9 @@
 		#size-cells = <0>;
 		reg = <0x45>;
 
+		gpio-controller;
+		#gpio-cells = <2>;
+
 		gta04_led0: red_aux at 0 {
 			label = "gta04:red:aux";
 			reg = <0x0>;
@@ -216,6 +219,11 @@
 			label = "gta04:green:power";
 			reg = <0x4>;
 		};
+
+		wifi_reset: wifi_reset at 6 {
+			reg = <0x6>;
+			compatible = "gpio";
+		};
 	};
 
 	/* compass aka magnetometer */
-- 
1.9.1
