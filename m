From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 17:52:25 +0800
Subject: [PATCH v2 2/3] arm: dts: rk322x: correct uart2 pinctrl and add
 another sets
In-Reply-To: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
References: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495014746-27621-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct UART2 PINCTRL flag and add another PINCTRL sets for UART2
in case of confict with SDMMC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index cc6a27d..fe6530f 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -693,7 +693,7 @@
 
 		uart2 {
 			uart2_xfer: uart2-xfer {
-				rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_none>,
+				rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_up>,
 						<1 19 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
@@ -705,5 +705,12 @@
 				rockchip,pins = <0 24 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
+
+		uart2-1 {
+			uart21_xfer: uart21-xfer {
+				rockchip,pins = <1 10 RK_FUNC_2 &pcfg_pull_up>,
+						<1 9 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
 	};
 };
-- 
2.0.0
