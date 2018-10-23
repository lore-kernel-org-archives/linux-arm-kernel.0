From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Tue, 23 Oct 2018 05:30:49 +0000
Subject: [PATCH V1 2/4] ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
In-Reply-To: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Message-ID: <20181023052831.2553-3-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 61d2d26afbf4..eb84ebcbe358 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -548,6 +548,7 @@
 				clocks = <&clks IMX6QDL_CLK_CAN1_IPG>,
 					 <&clks IMX6QDL_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x34 28 0x10 17>;
 				status = "disabled";
 			};
 
@@ -558,6 +559,7 @@
 				clocks = <&clks IMX6QDL_CLK_CAN2_IPG>,
 					 <&clks IMX6QDL_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x34 29 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1
