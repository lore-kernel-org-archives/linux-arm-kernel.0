From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 28 Sep 2018 14:16:43 +0200
Subject: [PATCH] ARM: dts: socfpga: arria10: add aliases for ethernet
Message-ID: <20180928121643.18100-1-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stmmac driver uses the alias id to enumerate multiple ethernet devices.
Add the aliases for ethernet, so multiple ethernet ports can be enabled
without errors.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index a4dcb68f4322..9d490f907c98 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -21,6 +21,13 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.19.0
