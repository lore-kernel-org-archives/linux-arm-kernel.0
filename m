From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Mar 2015 17:19:21 -0700
Subject: [PATCH 4/4] ARM: dts: Remove PIN_INPUT for dm816x McSPI
In-Reply-To: <1426637961-4197-1-git-send-email-tony@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
Message-ID: <1426637961-4197-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On dm816x we have no PIN_INPUT vs PIN_OUTPUT configuration, there
are just pulls. Let's remove the bogus flags.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index b520a8b..169a855 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -29,10 +29,10 @@
 &dm816x_pinmux {
 	mcspi1_pins: pinmux_mcspi1_pins {
 		pinctrl-single,pins = <
-			DM816X_IOPAD(0x0a94, PIN_INPUT | MUX_MODE0)	/* SPI_SCLK */
-			DM816X_IOPAD(0x0a98, PIN_OUTPUT | MUX_MODE0)	/* SPI_SCS0 */
-			DM816X_IOPAD(0x0aa8, PIN_INPUT | MUX_MODE0)	/* SPI_D0 */
-			DM816X_IOPAD(0x0aac, PIN_INPUT | MUX_MODE0)	/* SPI_D1 */
+			DM816X_IOPAD(0x0a94, MUX_MODE0)			/* SPI_SCLK */
+			DM816X_IOPAD(0x0a98, MUX_MODE0)			/* SPI_SCS0 */
+			DM816X_IOPAD(0x0aa8, MUX_MODE0)			/* SPI_D0 */
+			DM816X_IOPAD(0x0aac, MUX_MODE0)			/* SPI_D1 */
 		>;
 	};
 
-- 
2.1.4
