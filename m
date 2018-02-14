From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Wed, 14 Feb 2018 21:17:31 +0530
Subject: [PATCH] ARM: dts: rockchip: Add eMMC node for rk3288-vyasa
Message-ID: <1518623251-21562-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3288 Vyasa has eMMC, add dts node to support it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 9842a00..14c896bf 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -155,6 +155,17 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	status = "okay";
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>;
-- 
2.7.4
