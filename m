From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 04 Aug 2014 19:00:07 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add bootargs setting the correct
 serial console
In-Reply-To: <5084600.YbBVvXy6Ug@diego>
References: <5084600.YbBVvXy6Ug@diego>
Message-ID: <1539097.4Cm43oOanj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uart2 seems to be designated debug uart for all Rockchip platforms.
On all rk30xx and rk31xx boards I've seen so far, this uart was used
for the console and the rk3288 TRM even describes it as debug uart.

Thus add it to the core SoC dtsi files to not duplicate the same
information on every board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This makes a multi_v7_defconfig-based kernel start sucessfully on my
rk3188-radxarock and rk3288-evb

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 arch/arm/boot/dts/rk3xxx.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e7cb008..3950bad 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -36,6 +36,10 @@
 		serial4 = &uart4;
 	};
 
+	chosen {
+		bootargs = "console=ttyS2,115200";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 8caf85d..9eeb6cb 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -28,6 +28,10 @@
 		i2c4 = &i2c4;
 	};
 
+	chosen {
+		bootargs = "console=ttyS2,115200";
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.0.1
