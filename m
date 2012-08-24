From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 24 Aug 2012 11:17:43 +0200
Subject: [PATCH 2/5] ARM i.MX53, i.MX6q: Add IRAM to device tree
In-Reply-To: <1345799866-19876-1-git-send-email-p.zabel@pengutronix.de>
References: <1345799866-19876-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1345799866-19876-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |    5 +++++
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e3e8694..6d99d8a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -330,5 +330,10 @@
 				status = "disabled";
 			};
 		};
+
+		iram at f8000000 {
+			compatible = "fsl,imx-iram";
+			reg = <0xf8000000 0x20000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..bb34a28 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -87,6 +87,11 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		iram at 00900000 {
+			compatible = "fsl,imx-iram";
+			reg = <0x00900000 0x3f000>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.10.4
