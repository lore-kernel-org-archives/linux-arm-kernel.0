From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 May 2012 18:50:58 +0800
Subject: [PATCH 4/5] ARM: imx6q: add DT node for gpmi-nand
In-Reply-To: <1337856659-24812-1-git-send-email-b32955@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
Message-ID: <1337856659-24812-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for gpmi-nand.
Also enable the gpmi-nand for mx6q-arm2 board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi     |   12 ++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index db4c609..15f9e0b 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -22,6 +22,10 @@
 	};
 
 	soc {
+		gpmi-nand at 00112000 {
+			status = "okay";
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			ethernet at 02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cccac33..979d9f9 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -92,6 +92,18 @@
 			reg = <0x00110000 0x2000>;
 		};
 
+		gpmi-nand at 00112000 {
+			compatible = "fsl,imx6q-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <0 13 0x04>, <0 15 0x04>;
+			interrupt-names = "gpmi-dma", "bch";
+			fsl,gpmi-dma-channel = <0>;
+			status = "disabled";
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.0.4
