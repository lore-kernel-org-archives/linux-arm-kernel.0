From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 01 Aug 2015 14:35:18 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
Message-ID: <15143985.aGzb1oeyb9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 has problems accessing the memory region 0xfe000000~0xff000000.
So block off the affected region to prevent its use.

Tested on 4GB Veyron Minnie and 2GB Veyron Jerry devices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2db91c9..19766af 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -169,6 +169,16 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		unusable at fe000000 {
+			reg = <0xfe000000 0x1000000>;
+		};
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.1.4
