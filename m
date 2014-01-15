From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 12:27:29 +0100
Subject: [PATCH v2 03/12] at91: dt: sam9261: Added support for the lcd
 display
In-Reply-To: <52CED74B.3030806@overkiz.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
 <1389270709-32662-4-git-send-email-jjhiblot@traphandler.com>
 <52CED74B.3030806@overkiz.com>
Message-ID: <20140115112729.GS14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:07 Thu 09 Jan     , boris brezillon wrote:
> On 09/01/2014 13:31, Jean-Jacques Hiblot wrote:
> >Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> >---
> >  arch/arm/boot/dts/at91sam9261.dtsi  | 37 ++++++++++++++++++++++++++++++++++++-
> >  arch/arm/boot/dts/at91sam9261ek.dts | 31 +++++++++++++++++++++++++++++++
> >  arch/arm/mach-at91/at91sam9261.c    |  1 +
> >  3 files changed, 68 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
> >index 773c3d6..cd219b9 100644
> >--- a/arch/arm/boot/dts/at91sam9261.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9261.dtsi
> >@@ -290,7 +290,33 @@
> >  						atmel,pins = <AT91_PIOC 24 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> >  					};
> >  				};
> >-
> >+				fb {
> >+					pinctrl_fb: fb-0 {
> >+						atmel,pins =
> >+							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
> >+							 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
> >+							 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
> >+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
> >+							 AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB8 periph A */
> >+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
> >+							 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB10 periph A */
> >+							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB11 periph A */
> >+							 AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB12 periph A */
> >+							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB15 periph A */
> >+							 AT91_PIOB 16 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB16 periph A */
> >+							 AT91_PIOB 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB17 periph A */
> >+							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB18 periph A */
> >+							 AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB19 periph A */
> >+							 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB20 periph A */
> >+							 AT91_PIOB 23 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB23 periph B */
> >+							 AT91_PIOB 24 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB24 periph B */
> >+							 AT91_PIOB 25 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB25 periph B */
> >+							 AT91_PIOB 26 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB26 periph B */
> >+							 AT91_PIOB 27 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB27 periph B */
> >+							 AT91_PIOB 28 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PB28 periph B */
> >+							 >;
> >+					};
> >+				};
> >  				pioA: gpio at fffff400 {
> >  					compatible = "atmel,at91rm9200-gpio";
> >  					reg = <0xfffff400 0x200>;
> >@@ -436,6 +462,15 @@
> >  			};
> >  		};
> >+		fb0: fb at 0x00600000 {
> >+			compatible = "atmel,at91sam9261-lcdc";
> >+			reg = <0x00600000 0x1000>;
> >+			interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
> >+			pinctrl-names = "default";
> >+			pinctrl-0 = <&pinctrl_fb>;
> >+			status = "disabled";
> >+		};
> >+
> >  		nand0: nand at 40000000 {
> >  			compatible = "atmel,at91rm9200-nand";
> >  			#address-cells = <1>;
> >diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> >index f3d22a9..03c05fc 100644
> >--- a/arch/arm/boot/dts/at91sam9261ek.dts
> >+++ b/arch/arm/boot/dts/at91sam9261ek.dts
> >@@ -52,6 +52,37 @@
> >  				reg = <0x0 0x20000>;
> >  			};
> >  		};
> 
> One more nitpick :
> I think this should be taken out in another patch (first 9261 lcdc support,
> then ek board lcd def) :p.

yes mandatory

Best Regards,
J.
> 
> >+
> >+		fb0: fb at 0x00600000 {
> >+			display = <&display0>;
> >+			status = "okay";
> >+			atmel,power-control-gpio = <&pioA 12 GPIO_ACTIVE_LOW>;
> >+			display0: display {
> >+				bits-per-pixel = <16>;
> >+				atmel,lcdcon-backlight;
> >+				atmel,dmacon = <0x1>;
> >+				atmel,lcdcon2 = <0x80008002>;
> >+				atmel,guard-time = <1>;
> >+				atmel,lcd-wiring-mode = "BRG";
> >+
> >+				display-timings {
> >+					native-mode = <&timing0>;
> >+					timing0: timing0 {
> >+						clock-frequency = <4965000>;
> >+						hactive = <240>;
> >+						vactive = <320>;
> >+						hback-porch = <1>;
> >+						hfront-porch = <33>;
> >+						vback-porch = <1>;
> >+						vfront-porch = <0>;
> >+						hsync-len = <5>;
> >+						vsync-len = <1>;
> >+						hsync-active = <1>;
> >+						vsync-active = <1>;
> >+					};
> >+				};
> >+			};
> >+		};
> >  	};
> >  	leds {
> >diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> >index 200d17a..a67bfe6 100644
> >--- a/arch/arm/mach-at91/at91sam9261.c
> >+++ b/arch/arm/mach-at91/at91sam9261.c
> >@@ -197,6 +197,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	/* more tc lookup table for DT entries */
> >  	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
> >  	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
> >+	CLKDEV_CON_DEV_ID("hclk", "600000.fb", &hck1),
> >  	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
> >  	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
> >  	CLKDEV_CON_DEV_ID("mci_clk", "fffa8000.mmc", &mmc_clk),
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
