From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri,  4 Mar 2016 05:23:30 -0500
Subject: [PATCH 1/1] arm64: dts: Enable GPIO for Broadcom NS2 SoC
Message-ID: <1457087010-26306-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the GPIO support for Broadcom NS2 SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index a510d3a..dbe89d7 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -246,6 +246,15 @@
 			mask = <0xfffffffd>;
 		};
 
+		gpio_aon: gpio at 65024800 {
+			compatible = "brcm,iproc-gpio";
+			reg = <0x65024800 0x50>,
+			      <0x65024008 0x18>;
+			ngpios = <6>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
 		gic: interrupt-controller at 65210000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
@@ -266,6 +275,16 @@
 			status = "disabled";
 		};
 
+		gpio_g: gpio at 660a0000 {
+			compatible = "brcm,iproc-gpio";
+			reg = <0x660a0000 0x50>;
+			ngpios = <32>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		i2c1: i2c at 660b0000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x660b0000 0x100>;
-- 
2.1.0
