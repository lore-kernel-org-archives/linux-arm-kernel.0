From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:51 +0200
Subject: [PATCH 06/22] arm/dts: i.MX25: Add ssi clocks and DMA events.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-7-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index b318106..fb37111 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -293,6 +293,9 @@
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50014000 0x4000>;
 				interrupts = <11>;
+				clocks = <&clks 118>;
+				clock-names = "ssi2_ipg";
+				fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
@@ -323,6 +326,9 @@
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50034000 0x4000>;
 				interrupts = <12>;
+				clocks = <&clks 117>;
+				clock-names = "ssi1_ipg";
+				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
-- 
1.7.9.5
