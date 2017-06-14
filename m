From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 14 Jun 2017 22:48:55 +0200
Subject: [RFC PATCH 3/3] ARM: dts: imx7s: add rproc node
In-Reply-To: <20170614204855.18347-1-o.rempel@pengutronix.de>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
Message-ID: <20170614204855.18347-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksij Rempel <linux@rempel-privat.de>

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c138b0fb410a..8b84cd3cdd28 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -566,6 +566,14 @@
 			};
 		};
 
+		imx_rproc: imx7d-rp0 at 0 {
+			compatible	= "fsl,imx7d-rproc";
+			reg		= <0x00180000 0x4000>, <0x00184000 0x4000>;
+			reg-names	= "imem", "dmem";
+			syscon		= <&src>;
+			clocks		= <&clks IMX7D_ARM_M4_ROOT_CLK>;
+		};
+
 		aips2: aips-bus at 30400000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.11.0
