From: frank.wang@rock-chips.com (Frank Wang)
Date: Tue,  4 Jul 2017 16:12:43 +0800
Subject: [PATCH 2/6] ARM: dts: rockchip: add cpu-supply property for cpu node
 of rk3229-evb
In-Reply-To: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
References: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499155967-26090-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

This patch adds the cpu-supply property so that cpu can do dvfs
on rk3229-evb board.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 8b10c64..cfa7baa 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -126,6 +126,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
-- 
2.0.0
