From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 21 Mar 2017 18:40:22 +0300
Subject: [PATCH] ARM: dts: rockchip: increase SD clock frequency on Radxa Rock
Message-ID: <1490110822-3310-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set SD clock frequency to maximum possible to SD-card
(50MHz). This change actual clock frequency from 32MHz to 48MHz
(speedup 1.5X).

Banner line before patch: 'mmc_host mmc0: Bus speed (slot 0) = 32000000Hz
(slot req 50000000Hz, actual 32000000HZ div = 0)'.
Banner line after patch: 'mmc_host mmc0: Bus speed (slot 0) = 96000000Hz
(slot req 50000000Hz, actual 48000000HZ div = 1)'

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/boot/dts/rk3188-radxarock.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 1da46d1..5b7daa4 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -302,6 +302,7 @@
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
 	vmmc-supply = <&vcc_sd0>;
 
+	clock-frequency = <50000000>;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-- 
1.7.9.5
