From: david.wu@rock-chips.com (David Wu)
Date: Fri, 23 Jun 2017 13:04:09 +0800
Subject: [PATCH 11/11] ARM64: dts: rockchip: Enable gmac2phy for rk3328-evb
In-Reply-To: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1498194249-8368-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's enable the gmac2phy, make the gmac2phy work on
the rk3328-evb board.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index cf27239..b9f36da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -50,6 +50,23 @@
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&gmac2phy {
+	phy-supply = <&vcc_phy>;
+	clock_in_out = "output";
+	assigned-clocks = <&cru SCLK_MAC2PHY_SRC>;
+	assigned-clock-rate = <50000000>;
+	assigned-clocks = <&cru SCLK_MAC2PHY>;
+	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
+	status = "okay";
 };
 
 &uart2 {
-- 
1.9.1
