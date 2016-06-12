From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Sun, 12 Jun 2016 15:20:45 +0200
Subject: [PATCH 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
Message-ID: <6b48c849983548f29259b42d69c5224c@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentin Raevsky <valentin@compulab.co.il>

Fix the cm-fx6 operation points. Remove settings for 1.2GHz.
The current ldo settings do not allow 1.2GHz cpu frequency.

Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
[christopher.spinrath at rwth-aachen.de: rebased on upstream and adapted
 commit title]
Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 6d8d5e9..c912d58 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -91,6 +91,23 @@
 	};
 };
 
+&cpu0 {
+	operating-points = <
+		/* kHz	uV */
+		996000	1250000
+		852000	1250000
+		792000	1150000
+		396000	975000
+	>;
+	fsl,soc-operating-points = <
+		/* ARM kHz	SOC-PU uV */
+		996000		1250000
+		852000		1250000
+		792000		1175000
+		396000		1175000
+	>;
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <2>;
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio3 19 GPIO_ACTIVE_HIGH>;
-- 
2.8.3
