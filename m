From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Feb 2012 16:58:27 +0100
Subject: [PATCH 2/4] ARM: at91: dt: enable usb ohci for 9g20 and 9g45
In-Reply-To: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
References: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1329235109-6688-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
--
 arch/arm/boot/dts/at91sam9g20.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    7 +++++++
 arch/arm/boot/dts/usb_a9g20.dts        |    5 +++++
 arch/arm/mach-at91/at91sam9260.c       |    1 +
 arch/arm/mach-at91/at91sam9g45.c       |    1 +
 6 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 48c4e0a..6aa7d5e 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -206,6 +206,13 @@
 				status = "disabled";
 			};
 
+			usb0: ohci at 00500000 {
+				compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+				reg = <0x00500000 0x100000>;
+				interrupts = <20 4>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 25e09c5..a630430 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -206,6 +206,13 @@
 				status = "disabled";
 			};
 
+			usb0: ohci at 00700000 {
+				compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+				reg = <0x00700000 0x100000>;
+				interrupts = <22 4>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a130ace..6d67a44 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -155,6 +155,13 @@
 
 			};
 
+			usb0: ohci at 00700000 {
+				status = "okay";
+				num-ports = <2>;
+				atmel,vbus-gpio = <&pioD 1 12
+						   &pioD 3 12>;
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 643c1d4..3e1a93a 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -125,6 +125,11 @@
 				status = "okay";
 			};
 
+			usb0: ohci at 00500000 {
+				num-ports = <2>;
+				status = "okay";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index bff3406..e0dbbdf 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -211,6 +211,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fffd8000.serial", &usart5_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
+	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 5301633..63865f2 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -231,6 +231,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fff98000.serial", &usart3_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
+	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
