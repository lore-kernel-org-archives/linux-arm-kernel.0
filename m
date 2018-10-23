From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Tue, 23 Oct 2018 05:31:09 +0000
Subject: [PATCH V1 3/4] ARM: dts: imx6ul: Add flexcan stop mode wakeup support
In-Reply-To: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Message-ID: <20181023052831.2553-4-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6dc0b569acdf..76486a42959c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -407,6 +407,7 @@
 				clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
 					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 1 0x10 17>;
 				status = "disabled";
 			};
 
@@ -417,6 +418,7 @@
 				clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
 					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 2 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1
