From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:30:19 +0800
Subject: [PATCH v2 4/6] ARM: dts: rockchip: enable eMMC for rk3229-evb
In-Reply-To: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499243421-21460-5-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables eMMC support for rk3229-evb board.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 78a3ea1..a51ca01 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -145,6 +145,13 @@
 	cpu-supply = <&vdd_arm>;
 };
 
+&emmc {
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	status = "okay";
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
-- 
2.0.0
