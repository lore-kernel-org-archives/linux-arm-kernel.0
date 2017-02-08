From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 8 Feb 2017 10:33:51 -0200
Subject: [PATCH] ARM: dts: imx53-qsb: Constrain the TVE DAC voltage
Message-ID: <1486557231-8889-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Philipp Zabel:
"Since this regulator is used as the TVDAC analog power supply, this
range should at least be limited to the analog power supply range of the
TVDAC, listed in Table 74-9. of the i.MX53 reference manual (2.5-2.75V).

But since the nominal voltage is 2.75V, which was used to determine the
analog gain that is supposed to result in the necessary 0.7V
peak-to-peak amplitude on the VGA output, I'd say we should just fix the
voltage to 2750000 here."

, so limit the TVDAC analog power supply as suggested.

Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-qsb.dts  | 4 ++--
 arch/arm/boot/dts/imx53-qsrb.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index f4c158c..d3d662e 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -88,8 +88,8 @@
 			};
 
 			ldo7_reg: ldo7 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <2750000>;
+				regulator-max-microvolt = <2750000>;
 			};
 
 			ldo8_reg: ldo8 {
diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
index 479ca4c..de22158 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -128,8 +128,8 @@
 
 			vdac_reg: vdac {
 				regulator-name = "VDAC";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2775000>;
+				regulator-min-microvolt = <2750000>;
+				regulator-max-microvolt = <2750000>;
 			};
 
 			vgen1_reg: vgen1 {
-- 
2.7.4
