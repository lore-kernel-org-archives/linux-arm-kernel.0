From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 09:09:32 +0200
Subject: [PATCH v7 3/3] ARM: dts: imx6qdl.dtsi/imx6ul.dtsi: add "fsl,
 imx6q-snvs-lpgpr" node
In-Reply-To: <20170620070932.10353-1-o.rempel@pengutronix.de>
References: <20170620070932.10353-1-o.rempel@pengutronix.de>
Message-ID: <20170620070932.10353-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is for Low Power General Purpose Register which can
be used as Non-Volatile Storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 arch/arm/boot/dts/imx6ul.dtsi  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e426faa9c243..94e992558238 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -769,6 +769,10 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_lpgpr: snvs-lpgpr {
+					compatible = "fsl,imx6q-snvs-lpgpr";
+				};
 			};
 
 			epit1: epit at 020d0000 { /* EPIT1 */
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d09402..df870abc28f5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -624,6 +624,10 @@
 					linux,keycode = <KEY_POWER>;
 					wakeup-source;
 				};
+
+				snvs_lpgpr: snvs-lpgpr {
+					compatible = "fsl,imx6ul-snvs-lpgpr";
+				};
 			};
 
 			epit1: epit at 020d0000 {
-- 
2.11.0
