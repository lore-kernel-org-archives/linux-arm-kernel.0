From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Apr 2014 09:09:39 -0300
Subject: [PATCH] ARM: dts: imx6sl-evk: Add an entry for
 MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11
Message-ID: <1397218179-3533-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In case the bootloader has incorrectly configured the ALT mode of 
MX6SL_PAD_ECSPI1_SS0 pad, we end up with the following probe error:

m25p80 spi0.0: found mr25h256, expected m25p32
m25p80 spi0.0: mr25h256 (32 Kbytes)

In order to avoid this issue, add an entry for MX6SL_PAD_ECSPI1_SS0 pad, so
that kernel configures the ECSPI chip select as GPIO functionality, which
results in correct SPI NOR probe.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 864d8df..a8d9a93 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -282,6 +282,7 @@
 				MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO	0x100b1
 				MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x100b1
 				MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x100b1
+				MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11	0x80000000
 			>;
 		};
 
-- 
1.8.3.2
