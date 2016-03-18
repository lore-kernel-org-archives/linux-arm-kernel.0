From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:40:00 +0100
Subject: [PATCH 04/10] ARM: dts: rockchip: add startup delay to rk3288-veyron
 panel-regulators
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The panels need a bit of time to actually turn on. If this isn't
observed, this results in problems when trying talk to the panels
and thus produces detection errors. 100ms seem to be a safe value
for the time being.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 +
 arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 +
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 5c97e31..2123ac2 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -61,6 +61,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
+		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index 60bd6e9..1a9bef1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -60,6 +60,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
+		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 699beb0..8b16f37 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -70,6 +70,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
+		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index b34a7b5..e62cdee 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -61,6 +61,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
+		startup-delay-us = <100000>;
 		vin-supply = <&vcc33_sys>;
 	};
 
-- 
2.6.4
