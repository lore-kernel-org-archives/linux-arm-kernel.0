From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 19 Jan 2017 15:21:33 +0100
Subject: [PATCH 1/2] ARM: imx6: fix min/max voltage of anatop 2p5 regulator
Message-ID: <20170119142134.8572-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulation bound of this regulator are 2.1V to 2.875V, the
wrong DT values cause the driver to miscalculate the effective
voltage.

This isn't really an issue right now, as nobody actively changes
the regulator voltage, but better fix it now.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 53e6e63cbb02..9313b9af2da8 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -661,8 +661,8 @@
 					anatop-vol-bit-shift = <8>;
 					anatop-vol-bit-width = <5>;
 					anatop-min-bit-val = <0>;
-					anatop-min-voltage = <2000000>;
-					anatop-max-voltage = <2750000>;
+					anatop-min-voltage = <2100000>;
+					anatop-max-voltage = <2875000>;
 				};
 
 				reg_arm: regulator-vddcore {
-- 
2.11.0
