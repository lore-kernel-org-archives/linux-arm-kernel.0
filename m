From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 28 Aug 2012 13:40:54 +0530
Subject: [PATCH v4 3/3] arm/dts: AM33XX: Add D_CAN device tree data
In-Reply-To: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
Message-ID: <1346141454-18786-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Bosch D_CAN controller device tree data to AM33XX dtsi
file by adding d_can device nodes with all the necessary
parameters.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dfe9c559..d965137 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -177,5 +177,23 @@
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
 		};
+
+		dcan0: d_can at 481CC000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can0";
+			reg = <0x481CC000 0x2000>;
+			interrupts = <52>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
+
+		dcan1: d_can at 481D0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "d_can1";
+			reg = <0x481D0000 0x2000>;
+			interrupts = <55>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
