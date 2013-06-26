From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 16:57:04 +0200
Subject: [GIT PULL] at91: Device Tree updates for 3.11 #3
In-Reply-To: <1372237377-20315-1-git-send-email-nicolas.ferre@atmel.com>
References: <1372237377-20315-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201306261657.05191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Nicolas Ferre wrote:
> Arnd, Olof,
> 
> One more pull-request for AT91 DT patches.
> It is focused on SPI on several SoCs and it particular the SPI+DMA addition on newer
> SAMA5D3 and AT91SAM9N12.

Pulled into next/dt, thanks! I've performed the simple merge below.

	Arnd

diff --cc arch/arm/boot/dts/sama5d3.dtsi
index bbf88d7,5956f9b..a1d5e25
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@@ -80,9 -76,17 +80,12 @@@
  			spi0: spi at f0004000 {
  				#address-cells = <1>;
  				#size-cells = <0>;
- 				compatible = "atmel,at91sam9x5-spi";
+ 				compatible = "atmel,at91rm9200-spi";
  				reg = <0xf0004000 0x100>;
  				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
 -				cs-gpios = <&pioD 13 0
 -					    &pioD 14 0 /* conflicts with SCK0 and CANRX0 */
 -					    &pioD 15 0 /* conflicts with CTS0 and CANTX0 */
 -					    &pioD 16 0 /* conflicts with RTS0 and PWMFI3 */
 -					   >;
+ 				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(1)>,
+ 				       <&dma0 2 AT91_DMA_CFG_PER_ID(2)>;
+ 				dma-names = "tx", "rx";
  				pinctrl-names = "default";
  				pinctrl-0 = <&pinctrl_spi0>;
  				status = "disabled";
@@@ -203,9 -207,17 +206,12 @@@
  			spi1: spi at f8008000 {
  				#address-cells = <1>;
  				#size-cells = <0>;
- 				compatible = "atmel,at91sam9x5-spi";
+ 				compatible = "atmel,at91rm9200-spi";
  				reg = <0xf8008000 0x100>;
  				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 3>;
 -				cs-gpios = <&pioC 25 0
 -					    &pioC 26 0 /* conflitcs with TWD1 and ISI_D11 */
 -					    &pioC 27 0 /* conflitcs with TWCK1 and ISI_D10 */
 -					    &pioC 28 0 /* conflitcs with PWMFI0 and ISI_D9 */
 -					   >;
+ 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(15)>,
+ 				       <&dma1 2 AT91_DMA_CFG_PER_ID(16)>;
+ 				dma-names = "tx", "rx";
  				pinctrl-names = "default";
  				pinctrl-0 = <&pinctrl_spi1>;
  				status = "disabled";
