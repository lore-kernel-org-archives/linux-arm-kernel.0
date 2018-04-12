From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 12 Apr 2018 15:15:54 +0200
Subject: [PATCH 1/3] ARM: dts: imx6: RDU2: bump SoC/PU operating points by 25mV
Message-ID: <20180412131556.11073-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bumps the SoC/PU domain operating points by 25mV, giving a total
of 75mV margin to the minimum required voltages. This gets rid of
brown-outs seen due to voltage drop-out on the board.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 72f52fcecee1..4bc14b8e9a66 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -263,6 +263,17 @@
 	};
 };
 
+&cpu0 {
+	fsl,soc-operating-points = <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1300000
+		996000	1275000
+		852000	1275000
+		792000	1200000
+		396000	1200000
+	>;
+};
+
 &reg_arm {
 	vin-supply = <&sw1a_reg>;
 };
-- 
2.16.3
