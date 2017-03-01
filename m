From: romain.perier@collabora.com (Romain Perier)
Date: Wed,  1 Mar 2017 15:53:10 +0100
Subject: [PATCH 4/4] arm: dts: rockchip: Enable post_ios_power_on and
 pre-power-on-delay-ms
In-Reply-To: <20170301145310.22813-1-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
Message-ID: <20170301145310.22813-5-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the property post_ios_power_on. With this property, the
driver pwrseq_simple will do its entire power sequence at the end of the
mmc_power_up() function. The property pre-power-on-delay-ms adds a delay
of 1ms between the enablement of the clk and the assertion of the reset
line.

It fixes the power-up sequence for the Wifi chipset AP6335.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 818c4bf..9bf2991 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -106,6 +106,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable>;
 		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		pre-power-on-delay-ms = <1>;
+		post-ios-power-on;
 	};
 
 	vcc_usb_host: vcc-host-regulator {
-- 
2.9.3
