From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:04 +0200
Subject: [PATCH 1/14] ARM: LPC32xx: Add NAND flash timing to PHY3250 board dts
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds necessary NAND flash timings to the board specific dts file of
the PHY3250 reference board of the LPC32xx SoC.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/boot/dts/phy3250.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -54,6 +54,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			nxp,wdr-clks = <14>;
+			nxp,wwidth = <40000000>;
+			nxp,whold = <100000000>;
+			nxp,wsetup = <100000000>;
+			nxp,rdr-clks = <14>;
+			nxp,rwidth = <40000000>;
+			nxp,rhold = <66666666>;
+			nxp,rsetup = <100000000>;
+			nand-on-flash-bbt;
+			gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
+
 			mtd0 at 00000000 {
 				label = "phy3250-boot";
 				reg = <0x00000000 0x00064000>;
