From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 12:47:06 +0100
Subject: [PATCH v8 3/6] ARM: rockchip: add snoop-control-unit
In-Reply-To: <21117503.1c6iOkvYSr@phil>
References: <21117503.1c6iOkvYSr@phil>
Message-ID: <1830191.ln1GpHdqLv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device-node and config select to enable the
scu in all Rockchip Cortex-A9 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi  | 5 +++++
 arch/arm/mach-rockchip/Kconfig | 1 +
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
index cf073de..133410e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -5,6 +5,7 @@ config ARCH_ROCKCHIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
+	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select COMMON_CLK
-- 
1.8.5.3
