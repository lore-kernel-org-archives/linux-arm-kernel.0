From: cl@rock-chips.com (cl at rock-chips.com)
Date: Thu, 24 Aug 2017 10:37:03 +0800
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add cpu regulator for rk3328
 evaluation board
In-Reply-To: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
Message-ID: <1503542223-21044-4-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

RK3328 Evaluation Board use rk805 pmic, and one of the DCDCs in
rk805 is for cpu regulator, assign the cpu regulator, so the
cpufreq can work fine.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 30816c1..f82b2d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -96,6 +96,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
1.9.1
