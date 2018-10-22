From: megous@megous.com (megous at megous.com)
Date: Mon, 22 Oct 2018 18:43:51 +0200
Subject: [PATCH] ARM: dts: sun8i-a83t-tbs-a711: Change MMC0 bus-width to 4
Message-ID: <20181022164352.8804-1-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

The actual hardware has 4 data lines. Use them.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 7a1b6154cda9..f320f915b413 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -402,6 +402,7 @@
 	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
+	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.19.1
