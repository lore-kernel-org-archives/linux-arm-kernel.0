From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 18:04:20 +0800
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add default pinmux for uart0
In-Reply-To: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
References: <1442829860-4647-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442829860-4647-7-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add urt0 txd and rxd muxing setup in the dtsi because uart0 always uses
them to work, no other possibilities.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index c374f1d..e9409ec 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -288,12 +288,19 @@
 				clocks = <&osc>;
 				reg-shift = <2>;
 				status = "disabled";
+				pinctrl-0 = <&urt0_pmux>;
+				pinctrl-names = "default";
 			};
 		};
 
 		sm_pinctrl: pinctrl at fe2200 {
 			compatible = "marvell,berlin4ct-sm-pinctrl";
 			reg = <0xfe2200 0xc>;
+
+			urt0_pmux: urt0-pmux {
+				groups = "SM_URT0_TXD", "SM_URT0_RXD";
+				function = "urt0";
+			};
 		};
 	};
 };
-- 
2.5.3
