From: joel@jms.id.au (Joel Stanley)
Date: Thu, 22 Feb 2018 14:45:24 +1030
Subject: [PATCH] ARM: dts: aspeed-palmetto: Enable rear UART
Message-ID: <20180222041524.17867-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Palmetto BMC has a UART connected to a RS-232 transceiver designed
to be used as a serial console for the host processor. It appears as a
D-sub connector on the back of the chassis.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index bbddfe1d1cc8..b7d3d1825b93 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -82,6 +82,21 @@
 			&pinctrl_ddcclk_default &pinctrl_ddcdat_default>;
 };
 
+&uart1 {
+	/* Rear RS-232 connector */
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			&pinctrl_rxd1_default
+			&pinctrl_nrts1_default
+			&pinctrl_ndtr1_default
+			&pinctrl_ndsr1_default
+			&pinctrl_ncts1_default
+			&pinctrl_ndcd1_default
+			&pinctrl_nri1_default>;
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.15.1
