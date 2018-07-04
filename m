From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 Jul 2018 13:14:01 -0300
Subject: [PATCH 1/2] ARM: dts: imx51: Add M4IF support
Message-ID: <1530720842-28281-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As per the i.MX51 Reference Manual the M4IF register region
starts at 0x83fd8000 and has a 4kB address range.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 66e4187..b417c39 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -531,6 +531,11 @@
 				status = "disabled";
 			};
 
+			m4if: m4if at 83fd8000 {
+				compatible = "fsl,imx51-m4if";
+				reg = <0x83fd8000 0x1000>;
+			};
+
 			weim: weim at 83fda000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
-- 
2.7.4
