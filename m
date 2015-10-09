From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 14:52:02 +0800
Subject: [PATCH v3 6/6] arm64: dts: berlin4ct: add default pinmux for uart0
In-Reply-To: <1444373522-2119-1-git-send-email-jszhang@marvell.com>
References: <1444373522-2119-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444373522-2119-7-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add urt0 txd and rxd muxing setup in the dtsi because uart0 always uses
them to work, no other possibilities.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 8e66355..a4a1876 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -288,12 +288,19 @@
 				clocks = <&osc>;
 				reg-shift = <2>;
 				status = "disabled";
+				pinctrl-0 = <&uart0_pmux>;
+				pinctrl-names = "default";
 			};
 		};
 
 		system_pinctrl: pin-controller at fe2200 {
 			compatible = "marvell,berlin4ct-system-pinctrl";
 			reg = <0xfe2200 0xc>;
+
+			uart0_pmux: uart0-pmux {
+				groups = "SM_URT0_TXD", "SM_URT0_RXD";
+				function = "uart0";
+			};
 		};
 	};
 };
-- 
2.6.1
