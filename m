From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 18 Jul 2014 20:14:30 +0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: add always on pcie regulator
Message-ID: <1405707270-22901-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everything in the PCI specification assumes devices to be
enumerable on startup. This is only possible if they have
power available.

A future improvement may allow this regulator to be switched
off for D3hot and D3cold power states, but there is a lot
of work to do the pcie host controller side for this to work.
To keep things simple always enable the regulator for now.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index ec43dde78525..bbbd501098e6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -54,6 +54,17 @@
 			gpio = <&gpio4 10 0>;
 			enable-active-high;
 		};
+
+		reg_pcie: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "pcie-supply";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 19 0>;
+			regulator-always-on;
+			enable-active-high;
+		};
 	};
 
 	gpio-keys {
@@ -323,6 +334,7 @@
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
 			>;
 		};
 
-- 
2.0.1
