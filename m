From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 25 Jul 2017 17:22:55 +0800
Subject: [PATCH] arm64: dts: rockchip: update dynamic-power-coefficient for
 rk3399
Message-ID: <1500974575-2244-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the dynamic-power-coefficient for big cluster on
rk3399 SoCs.

The dynamic power consumption of the CPU is proportional to the square of
the Voltage (V) and the clock frequency (f). The coefficient is used to
calculate the dynamic power as below -
Pdyn = dynamic-power-coefficient * V^2 * f
Where Voltage is in uV, frequency is in MHz.

As the following is the tested data on rk3399's big cluster.
frequency(MHz)  Voltage(V)  Current(mA) Dynamic-power-coefficient
24              0.8         15
48              0.8         23          ~417
96              0.8         40          ~443
216             0.8         82          ~438
312             0.8         115         ~430
408             0.8         150         ~455
So the dynamic-power-coefficient average value is about 436.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9d02006..5d54a06 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -150,7 +150,7 @@
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKB>;
-			dynamic-power-coefficient = <100>;
+			dynamic-power-coefficient = <436>;
 		};
 
 		cpu_b1: cpu at 101 {
@@ -159,7 +159,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKB>;
-			dynamic-power-coefficient = <100>;
+			dynamic-power-coefficient = <436>;
 		};
 	};
 
-- 
2.7.4
