From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  3 Sep 2012 18:02:07 +0200
Subject: [PATCH v3 3/4] ARM: dts: add sram for imx53 and imx6q
In-Reply-To: <1346688128-22395-1-git-send-email-p.zabel@pengutronix.de>
References: <1346688128-22395-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1346688128-22395-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |    5 +++++
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..2767a92 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -337,5 +337,10 @@
 				status = "disabled";
 			};
 		};
+
+		ocram: ocram at f8000000 {
+			compatible = "fsl,imx-ocram", "sram";
+			reg = <0xf8000000 0x20000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fd57079..1e463c4 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -111,6 +111,11 @@
 		       status = "disabled";
 		};
 
+		ocram: ocram at 00900000 {
+			compatible = "fsl,imx-ocram", "sram";
+			reg = <0x00900000 0x3f000>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.10.4
