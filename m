From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 22 Oct 2013 16:01:53 +0200
Subject: [PATCH v5 2/5] ARM: rockchip: add snoop-control-unit
In-Reply-To: <201310221600.13562.heiko@sntech.de>
References: <201310221600.13562.heiko@sntech.de>
Message-ID: <201310221601.54316.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device-node and config select to enable the
scu in all Rockchip Cortex-A9 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi  |    5 +++++
 arch/arm/mach-rockchip/Kconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 0fcbcfd..0a3d5b1 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -26,6 +26,11 @@
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
index 6fef464..8700395 100644
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
