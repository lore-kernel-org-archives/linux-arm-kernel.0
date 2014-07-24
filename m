From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Thu, 24 Jul 2014 15:38:24 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
Message-ID: <53D10C50.50305@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After ROMBOOT tries boot from flash on SPI0 NPCS0, this NPCS0 (PA14) remains set to PERIPH_A.
Because of that, this pin is unusable to something else.
This patch sets it back to GPIO.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

-------------- next part --------------
--- a/linux-3.16-rc6/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/linux-3.16-rc6/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -624,7 +624,8 @@
 						atmel,pins =
 							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA11 periph A SPI0_MISO pin */
 							 AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA12 periph A SPI0_MOSI pin */
-							 AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA13 periph A SPI0_SPCK pin */
+							 AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA13 periph A SPI0_SPCK pin */
+							 AT91_PIOA 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>; /* set from ROMBOOT to periph A */
 					};
 				};
