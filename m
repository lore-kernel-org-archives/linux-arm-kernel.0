From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 31 Aug 2012 11:26:58 +0200
Subject: [PATCH v2 3/9] ARM i.MX6: Add OCRAM to device tree
In-Reply-To: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1346405224-20399-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Renamed "iram" to "ocram" as it appears in the processor
   reference manuals.
---
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fd57079..9cb0b50 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -111,6 +111,11 @@
 		       status = "disabled";
 		};
 
+		ocram at 00900000 {
+			compatible = "fsl,imx-ocram";
+			reg = <0x00900000 0x3f000>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.10.4
