From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  9 Jan 2013 18:17:16 +0100
Subject: [RFC PATCH 2/5] ARM i.MX6q: Link system reset controller (SRC) to IPU
 in DT
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1357751839-19680-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..aac017b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -555,6 +555,7 @@
 				compatible = "fsl,imx6q-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
+				#reset-cells = <1>;
 			};
 
 			gpc: gpc at 020dc000 {
@@ -1046,6 +1047,7 @@
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
+			reset = <&src 2>;
 		};
 
 		ipu2: ipu at 02800000 {
@@ -1055,6 +1057,7 @@
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
+			reset = <&src 4>;
 		};
 	};
 };
-- 
1.7.10.4
