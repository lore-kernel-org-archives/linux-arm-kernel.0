From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:31 +0300
Subject: [PATCH v7 4/7] ARM: dts: rockchip: add clockevent attribute to
 rockchip timers
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-5-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All rockchip timers present in the DT act as clockevent.
It is possible to specify timer role using DT attribute.
Mark them accordingly.

Also this patch specify that for timer should be called init
function specified with CLOCKEVENT_OF_DECLARE().

Without the commit boot warnings will appear because clock
framework will try initialize them as clocksource.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi            |    1 +
 arch/arm/boot/dts/rk322x.dtsi            |    1 +
 arch/arm/boot/dts/rk3288.dtsi            |    1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 843d2be..a04bb5a 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -353,6 +353,7 @@
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
 		clock-names = "timer", "pclk";
+		clockevent;
 	};
 
 	pwm0: pwm at 20050000 {
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 2a4eee2..2250640 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -328,6 +328,7 @@
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
 		clock-names = "timer", "pclk";
+		clockevent;
 	};
 
 	cru: clock-controller at 110e0000 {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 91c4b3c..f45b7ad 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -217,6 +217,7 @@
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
 		clock-names = "timer", "pclk";
+		clockevent;
 	};
 
 	display-subsystem {
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4f44d11..054dadd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -673,6 +673,7 @@
 		compatible = "rockchip,rk3368-timer", "rockchip,rk3288-timer";
 		reg = <0x0 0xff810000 0x0 0x20>;
 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		clockevent;
 	};
 
 	gic: interrupt-controller at ffb71000 {
-- 
1.7.9.5
