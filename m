From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 11 Apr 2017 07:27:24 +0200
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl.dtsi: add "fsl,
 imx6q-snvs-lpgpr" node
In-Reply-To: <20170411052725.17464-1-o.rempel@pengutronix.de>
References: <20170410182235.pmobyxn6kvyvcwsj@rob-hp-laptop>
 <20170411052725.17464-1-o.rempel@pengutronix.de>
Message-ID: <20170411052725.17464-3-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is for Low Power General Purpose Register which can
be used as Non-Volatile Storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6d7bf6496117..8e90014705c3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -768,6 +768,12 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_lpgpr: snvs-lpgpr {
+					compatible = "fsl,imx6q-snvs-lpgpr";
+					regmap = <&snvs>;
+					offset = <0x68>;
+				};
 			};
 
 			epit1: epit at 020d0000 { /* EPIT1 */
-- 
2.11.0
