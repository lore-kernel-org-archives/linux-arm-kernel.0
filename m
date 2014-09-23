From: andreas.henriksson@endian.se (Andreas Henriksson)
Date: Tue, 23 Sep 2014 13:42:44 +0200
Subject: [PATCH] ARM: at91: fix at91sam9263ek DT mmc pinmuxing settings
Message-ID: <1411472564-32448-1-git-send-email-andreas.henriksson@endian.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discovered on a custom board similar to at91sam9263ek and basing
its devicetree on that one apparently the pin muxing doesn't get
set up properly. This was discovered since the custom boards u-boot
does funky stuff with the pin muxing and leaved it set to SPI
which made the MMC driver not work under Linux.
The fix is simply to define the given configuration as the default.
This probably worked by pure luck before, but it's better to
make the muxing explicitly set.

CC: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Andreas Henriksson <andreas.henriksson@endian.se>
---
 arch/arm/boot/dts/at91sam9263ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 5cf93ee..33a4f9a 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -64,6 +64,7 @@
 			};
 
 			mmc0: mmc at fff80000 {
+				pinctrl-names = "default";
 				pinctrl-0 = <
 					&pinctrl_board_mmc0
 					&pinctrl_mmc0_clk
-- 
2.1.0
