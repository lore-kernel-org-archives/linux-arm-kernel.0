From: denis@eukrea.com (Denis Carikli)
Date: Mon, 21 Oct 2013 11:51:34 +0200
Subject: [PATCHv4][ 07/11] ARM: dts: i.MX25: Add ssi clocks and DMA events.
In-Reply-To: <1382349098-11502-1-git-send-email-denis@eukrea.com>
References: <1382349098-11502-1-git-send-email-denis@eukrea.com>
Message-ID: <1382349098-11502-7-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 6ac4c98..cce0669 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -339,6 +339,11 @@
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50014000 0x4000>;
 				interrupts = <11>;
+				clocks = <&clks 118>;
+				clock-names = "ipg";
+				dmas = <&sdma 24 1 0>,
+				       <&sdma 25 1 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -369,6 +374,11 @@
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50034000 0x4000>;
 				interrupts = <12>;
+				clocks = <&clks 117>;
+				clock-names = "ipg";
+				dmas = <&sdma 28 1 0>,
+				       <&sdma 29 1 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -539,7 +549,7 @@
 				#interrupt-cells = <2>;
 			};
 
-			sdma at 53fd4000 {
+			sdma: sdma at 53fd4000 {
 				compatible = "fsl,imx25-sdma", "fsl,imx35-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
-- 
1.7.9.5
