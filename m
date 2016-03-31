From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 23:24:43 +0200
Subject: [PATCH] ARM: dts: rockchip: update rk3288-veyron cpu operating points
Message-ID: <1459459483-5356-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic operating points specified in rk3288.dtsi are specified by
Rockchip as conservative and for all cases.

In contrast the Veyron ChromeOS devices are supposed to use a special
chip variant often called rk3288-c and use different operating points
in their kernel also including a higher max frequency.

So override the operating points for veyron devices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 274fa87..df7d70d 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -170,6 +170,22 @@
 
 &cpu0 {
 	cpu0-supply = <&vdd_cpu>;
+	operating-points = <
+		/* KHz    uV */
+		1800000 1400000
+		1704000 1350000
+		1608000 1300000
+		1512000 1250000
+		1416000 1200000
+		1200000 1100000
+		1008000 1050000
+		 816000 1000000
+		 696000  950000
+		 600000  900000
+		 408000  900000
+		 216000  900000
+		 126000  900000
+	>;
 };
 
 &emmc {
-- 
2.1.4
