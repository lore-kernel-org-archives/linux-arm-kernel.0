From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Tue, 23 Oct 2018 05:30:44 +0000
Subject: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup support
In-Reply-To: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Message-ID: <20181023052831.2553-2-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa39364f..3f459d6da7fc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -448,6 +448,7 @@
 				clocks = <&clks IMX6SX_CLK_CAN1_IPG>,
 					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 1 0x10 17>;
 				status = "disabled";
 			};
 
@@ -458,6 +459,7 @@
 				clocks = <&clks IMX6SX_CLK_CAN2_IPG>,
 					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 2 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1
