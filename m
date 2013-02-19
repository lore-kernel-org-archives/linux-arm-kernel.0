From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 12:35:28 +0100
Subject: [PATCH v3 4/8] ARM i.MX6q: Link system reset controller (SRC) to IPU
 in DT
In-Reply-To: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1361273732-23357-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes since v2:
 - Rebased onto next-20120219
---
 arch/arm/boot/dts/imx6q.dtsi   |    1 +
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..4cd4f8d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -291,6 +291,7 @@
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 4>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 06ec460..3e21e92 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -516,6 +516,7 @@
 				compatible = "fsl,imx6q-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
+				#reset-cells = <1>;
 			};
 
 			gpc: gpc at 020dc000 {
@@ -795,6 +796,7 @@
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 2>;
 		};
 	};
 };
-- 
1.7.10.4
