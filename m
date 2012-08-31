From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 31 Aug 2012 11:26:57 +0200
Subject: [PATCH v2 2/9] ARM i.MX53: Add OCRAM to device tree
In-Reply-To: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1346405224-20399-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 - Renamed "iram" to "ocram" as it appears in the processor
   reference manuals.
---
 arch/arm/boot/dts/imx53.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..5da342a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -337,5 +337,10 @@
 				status = "disabled";
 			};
 		};
+
+		ocram at f8000000 {
+			compatible = "fsl,imx-ocram";
+			reg = <0xf8000000 0x20000>;
+		};
 	};
 };
-- 
1.7.10.4
