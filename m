From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 5 Jul 2013 14:41:57 +0200
Subject: [PATCH v3 3/6] ARM: rockchip: add snoop-control-unit
In-Reply-To: <201307051440.19428.heiko@sntech.de>
References: <201307051440.19428.heiko@sntech.de>
Message-ID: <201307051441.57325.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device-node and config select to enable the
scu in all Rockchip Cortex-A9 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi |    5 +++++
 arch/arm/mach-rockchip/Kconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 56bfac9..26c4311 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -48,6 +48,11 @@
 		compatible = "simple-bus";
 		ranges;
 
+		scu at 1013c000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0x1013c000 0x100>;
+		};
+
 		gic: interrupt-controller at 1013d000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 25ee12b..0f5484c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -5,6 +5,7 @@ config ARCH_ROCKCHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
+	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
 	select LOCAL_TIMERS if SMP
-- 
1.7.10.4
