From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed, 23 Aug 2017 16:40:32 +0800
Subject: [PATCH v1 3/3] arm64: dts: rockchip: add cpu regulator for rk3328
 evaluation board
In-Reply-To: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
References: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Message-ID: <1503477632-9661-4-git-send-email-cl@rock-chips.com>
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
index 479f9d9..b0658f4 100644
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
