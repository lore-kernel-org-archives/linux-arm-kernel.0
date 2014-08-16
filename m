From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 16 Aug 2014 17:18:35 +0200
Subject: [PATCH v3 7/7] arm: dts: am33xx, Add syscon phandle to cpsw node
In-Reply-To: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1408202315-20006-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 2 MACIDs stored in the control module of the am33xx. These are
read by the cpsw driver if no valid MACID was found in the devicetree.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index cb1113bcc290..5e9bfb3b9f1d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -692,6 +692,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
+			syscon = <&cm>;
 			status = "disabled";
 
 			davinci_mdio: mdio at 4a101000 {
-- 
2.0.1
