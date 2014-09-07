From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Sep 2014 19:19:35 +0200
Subject: [PATCH v6 7/7] arm: dts: am33xx, Add syscon phandle to cpsw node
In-Reply-To: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1410110375-3570-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 2 MACIDs stored in the control module of the am33xx. These are
read by the cpsw driver if no valid MACID was found in the devicetree.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 25e38b6ac376..13e44b0f5adc 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -701,6 +701,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
+			syscon = <&cm>;
 			status = "disabled";
 
 			davinci_mdio: mdio at 4a101000 {
-- 
2.1.0
