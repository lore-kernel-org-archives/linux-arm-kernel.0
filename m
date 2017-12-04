From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  4 Dec 2017 11:45:20 +0100
Subject: [PATCH] ARM: dts: rockchip: add cpu0-regulator on rk3066a-marsboard
Message-ID: <20171204104520.29385-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3066 also has operating points now, but without adjusting
the cpu-regulator will break once higher voltages are needed for
a specific frequency, so add the needed cpu0-regulator.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-marsboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index c6d92c25df42..d23ee6d911ac 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -83,6 +83,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_arm>;
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.14.2
