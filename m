From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri,  3 Nov 2017 10:54:59 +0100
Subject: [PATCH] ARM: dts: imx6: RDU2: add i210 node
Message-ID: <20171103095459.29272-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for the bootloader to patch in the correct MAC address.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index f939cf67c08f..4455a13f5d66 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -580,6 +580,18 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	host at 0 {
+		reg = <0 0 0 0 0>;
+		device_type = "pci";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		i210: i210 at 0 {
+			reg = <0 0 0 0 0>;
+		};
+	};
 };
 
 &usdhc2 {
-- 
2.11.0
