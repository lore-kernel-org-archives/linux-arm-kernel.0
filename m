From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 10:48:27 +0100
Subject: [PATCH 3/5] DTS: Add device tree entry for onewire master on i.MX53
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116094827.9660.48488.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/boot/dts/imx53.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index edc3f1e..00c957c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -387,6 +387,14 @@
 					};
 				};
 
+				owire {
+					pinctrl_owire_1: owiregrp-1 {
+						fsl,pins = <
+								1166 0x80000000 /* MX53_PAD_GPIO_18__OWIRE_LINE */
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
@@ -570,6 +578,13 @@
 				status = "disabled";
 			};
 
+			owire: owire@63fa4000 {
+				compatible = "fsl,imx53-owire", "fsl,imx21-owire";
+				reg = <0x63fa4000 0x4000>;
+				clocks = <&clks 159>;
+				status = "disabled";
+			};
+
 			ecspi2: ecspi at 63fac000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
