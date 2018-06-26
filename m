From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Jun 2018 20:18:52 -0300
Subject: [PATCH] ARM: dts: imx51: Add sahara crypto support
Message-ID: <1530055132-16538-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The sahara crypto block on i.MX51 has the same IP version as
the one on i.MX53.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fe01b89..89afb4b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -588,6 +588,15 @@
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
+
+			sahara: crypto at 83ff8000 {
+				compatible = "fsl,imx53-sahara", "fsl,imx51-sahara";
+				reg = <0x83ff8000 0x4000>;
+				interrupts = <19 20>;
+				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
+					 <&clks IMX5_CLK_SAHARA_IPG_GATE>;
+				clock-names = "ipg", "ahb";
+			};
 		};
 	};
 };
-- 
2.7.4
