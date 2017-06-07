From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed,  7 Jun 2017 12:32:40 +0200
Subject: [PATCH 2/4] ARM: dts: tps65217: Add backlight and pmic device
In-Reply-To: <20170607103242.16008-1-enric.balletbo@collabora.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
Message-ID: <20170607103242.16008-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the backlight driver but disable by default and also add the
compatible string for regulators.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 02de56b..233581f 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -16,6 +16,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	backlight {
+		compatible = "ti,tps65217-bl";
+		status = "disabled";
+	};
+
 	charger {
 		compatible = "ti,tps65217-charger";
 		status = "disabled";
@@ -27,6 +32,7 @@
 	};
 
 	regulators {
+		compatible = "ti,tps65217-pmic";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.9.3
