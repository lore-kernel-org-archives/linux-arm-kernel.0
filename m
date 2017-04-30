From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 30 Apr 2017 20:30:53 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: List charger as power supply for sbs
 battery
In-Reply-To: <20170430183054.24563-1-contact@paulk.fr>
References: <20170430183054.24563-1-contact@paulk.fr>
Message-ID: <20170430183054.24563-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lists the GPIO charger node as power supply for the battery, which
in turns allows receiving external power notifications and synchronizing
the charging state as soon as possible.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi | 1 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
index 71f5c5ecce46..8e4d2b9a35e1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
@@ -48,5 +48,6 @@
 		reg = <0xb>;
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <1>;
+		power-supplies = <&charger>;
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a315f884..fd4a3886c94b 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -99,7 +99,7 @@
 		pwm-delay-us = <10000>;
 	};
 
-	gpio-charger {
+	charger: gpio-charger {
 		compatible = "gpio-charger";
 		charger-type = "mains";
 		gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
-- 
2.12.2
