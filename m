From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 18 Apr 2016 07:12:00 +0300
Subject: [PATCH] ARM: dts: lpc32xx: set default clock rate of HCLK PLL
Message-ID: <1460952720-6638-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably most of NXP LPC32xx boards have 13MHz main oscillator and
therefore for HCLK PLL and ARM core clock rate default hardware
setting is 16 * 13MHz = 208MHz, however a user may vary HCLK PLL/ARM
core rate from 156MHz to about 266MHz for 13MHz clock source.

The change explicitly defines HCLK PLL output rate to default 208MHz
to overwrite any settings done by a bootloader, if needed it can be
redefined in a board DTS file.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
The change was discussed on linux-clk mailing list, from that
times I grab Sylvain's acked-by tag:

  http://www.spinics.net/lists/devicetree/msg116863.html

 arch/arm/boot/dts/lpc32xx.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c58d8da..d7b84cd 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -294,6 +294,9 @@
 
 					clocks = <&xtal_32k>, <&xtal>;
 					clock-names = "xtal_32k", "xtal";
+
+					assigned-clocks = <&clk LPC32XX_CLK_HCLK_PLL>;
+					assigned-clock-rates = <208000000>;
 				};
 			};
 
-- 
2.1.4
