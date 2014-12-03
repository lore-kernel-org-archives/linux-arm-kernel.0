From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:03 +0100
Subject: [PATCH 04/11] ARM: at91/dt: at91sam9261: fix clocks and clock-names
 in udc definition
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peripheral clock is named pclk and system clock is named hclk (those are
the names expected by the at91_udc driver).

Drop the deprecated usb_clk (formerly used to configure the usb clock rate
which is now directly configurable through hclk).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index a81aab4..7119f1f 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -122,8 +122,8 @@
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&usb>, <&udc_clk>, <&udpck>;
-				clock-names = "usb_clk", "udc_clk", "udpck";
+				clocks = <&udc_clk>, <&udpck>;
+				clock-names = "pclk", "hclk";
 				status = "disabled";
 			};
 
-- 
1.9.1
