From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:59 +0200
Subject: [PATCH 15/16] ARM: dts: i.MX51 babbage: Add spi-cs-high property to
 pmic
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-16-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mc13892 driver knows that it needs spi-cs-high, so the mc13892
will work. The dataflash also connected to this bus though can only
be probed when the mc13892 is inactive. Due to driver potential
differences in the probe order we can only make sure the mc13892
is inactive when we put the information into the devicetree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51-babbage.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6dd9486..9630b61 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -98,6 +98,7 @@
 		#size-cells = <0>;
 		compatible = "fsl,mc13892";
 		spi-max-frequency = <6000000>;
+		spi-cs-high;
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 0x4>;
-- 
1.8.3.1
