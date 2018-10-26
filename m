From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Fri, 26 Oct 2018 09:47:14 +0000
Subject: [PATCH V2 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup support
In-Reply-To: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
References: <20181026094444.25305-1-qiangqing.zhang@nxp.com>
Message-ID: <20181026094444.25305-5-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index aa8df7d93b2e..25571f31016c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -875,6 +875,7 @@
 				clocks = <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN1_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 1 0x10 17>;
 				status = "disabled";
 			};
 
@@ -885,6 +886,7 @@
 				clocks = <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN2_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 2 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1
