From: roger.chen@rock-chips.com (Roger Chen)
Date: Wed,  6 Jul 2016 18:51:31 +0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add GMAC dt nodes for RK3399 evb
In-Reply-To: <1467802291-6487-1-git-send-email-roger.chen@rock-chips.com>
References: <1467802291-6487-1-git-send-email-roger.chen@rock-chips.com>
Message-ID: <1467802291-6487-4-git-send-email-roger.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add ethernet GMAC dt nodes for RK3399 evaluation board.

Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 1a3eb14..337c939 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -69,6 +69,13 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
 	vcc_phy: vcc-phy-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
@@ -122,3 +129,19 @@
 		};
 	};
 };
+
+&gmac {
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	assigned-clocks = <&cru SCLK_RMII_SRC>;
+	assigned-clock-parents = <&clkin_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
+	status = "okay";
+};
-- 
1.9.1
