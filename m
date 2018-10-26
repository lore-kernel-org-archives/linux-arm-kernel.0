From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Fri, 26 Oct 2018 09:47:10 +0000
Subject: [PATCH V2 3/4] ARM: dts: imx6ul: Add flexcan stop mode wakeup support
In-Reply-To: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
References: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
Message-ID: <20181026094444.25305-4-qiangqing.zhang@nxp.com>
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
index 083d3446c41d..26e2e5da8170 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -408,6 +408,7 @@
 				clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
 					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 1 0x10 17>;
 				status = "disabled";
 			};
 
@@ -418,6 +419,7 @@
 				clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
 					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 2 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1
