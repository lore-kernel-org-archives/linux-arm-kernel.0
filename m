From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  9 Jul 2018 15:19:14 -0300
Subject: [PATCH v2 2/3] ARM: dts: imx51: Add M4IF support
In-Reply-To: <1531160355-12384-1-git-send-email-festevam@gmail.com>
References: <1531160355-12384-1-git-send-email-festevam@gmail.com>
Message-ID: <1531160355-12384-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As per the i.MX51 Reference Manual the M4IF register region
starts at 0x83fd8000 and has a 4kB address range.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Sergey Lapin <sergey.lapin@cogentembedded.com>
---
Changes since v1:
- None

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
