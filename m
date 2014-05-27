From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 27 May 2014 17:19:59 +0200
Subject: [PATCH] ARM: dts: pfla02: Add ethernet phy supply regulator
Message-ID: <1401203999-4344-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2.5V VDD_ETH_IO voltage supplied by the DA9063 LDO4 is used
to power the KSZ9031 PHY DVDDH input and to pull the necessary
pins (including bootstrap pins) high.
It also powers the i.MX6 NVCC_RGMII and NVCC_ENET inputs.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index faa3494..2694aa8 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -301,6 +301,7 @@
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+	phy-supply = <&vdd_eth_io_reg>;
 	status = "disabled";
 };
 
-- 
2.0.0.rc2
