From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Feb 2012 16:58:29 +0100
Subject: [PATCH 4/4] ARM: at91: dt: enable usb ehci for 9g45
In-Reply-To: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
References: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1329235109-6688-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g45.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    4 ++++
 arch/arm/mach-at91/at91sam9g45.c       |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index a630430..694fd1e 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -213,6 +213,13 @@
 				status = "disabled";
 			};
 
+			usb1: ehci at 00800000 {
+				compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
+				reg = <0x00800000 0x100000>;
+				interrupts = <22 4>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 6d67a44..824516c 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -162,6 +162,10 @@
 						   &pioD 3 12>;
 			};
 
+			usb1: ehci at 00800000 {
+				status = "okay";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 63865f2..2d57370 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -232,6 +232,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
