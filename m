From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:45 +0100
Subject: [PATCH 8/9] ARM: at91: sam9g45 add udc DT support
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     |   66 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    5 ++
 arch/arm/mach-at91/at91sam9g45.c       |    2 +
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 4b54424..98407c7 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -179,6 +179,72 @@
 				interrupts = <25 4>;
 				status = "disabled";
 			};
+
+			usb2: gadget at fff78000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91sam9rl-udc";
+				reg = <0x00600000 0x80000
+				       0xfff78000 0x400>;
+				interrupts = <27 4>;
+				status = "disabled";
+
+				ep0 {
+					reg = <0>;
+					atmel,fifo-size = <64>;
+					atmel,nb-banks = <1>;
+					atmel,can-dma = <0>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep1 {
+					reg = <1>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <2>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep2 {
+					reg = <2>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <2>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep3 {
+					reg = <3>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep4 {
+					reg = <4>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep5 {
+					reg = <5>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep6 {
+					reg = <6>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 4b1eb36..6dd2044 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -35,6 +35,11 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			usb2: gadget at fff78000 {
+				atmel,vbus-gpio = <&pioB 19 0>;
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index df3bcea..da80f0c 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -234,6 +234,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("hclk", "600000.gadget", &utmi_clk),
+	CLKDEV_CON_DEV_ID("pclk", "600000.gadget", &udphs_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
