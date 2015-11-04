From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Nov 2015 22:30:33 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0 bus
In-Reply-To: <5639C821.9040405@atmel.com>
References: <1446420376-5419-1-git-send-email-marex@denx.de>
 <5639C821.9040405@atmel.com>
Message-ID: <201511042230.33626.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 04, 2015 at 09:56:01 AM, Nicolas Ferre wrote:
> Le 02/11/2015 00:26, Marek Vasut a ?crit :
> > Add pinmux for the 4 remaining signals used in 8-bit MMC 0 bus
> > configuration.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de> Cc: Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> Cc: Josh Wu
> > <josh.wu@atmel.com> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > --- arch/arm/boot/dts/sama5d4.dtsi | 8 ++++++++ 1 file changed, 8
> > insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sama5d4.dtsi
> > b/arch/arm/boot/dts/sama5d4.dtsi index 8d1de29..f9f6108 100644 ---
> > a/arch/arm/boot/dts/sama5d4.dtsi +++
> > b/arch/arm/boot/dts/sama5d4.dtsi @@ -1651,6 +1651,14 @@ AT91_PIOC 9
> > AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with
> > NAND_D4 */
> 
> Oh, I see an error over there: it's actually MCI0_DA3 in the comment!
> Idea for another patch ;-)

Oh, nice catch. I created such patch and will submit it shortly.

> > >; }; +					pinctrl_mmc0_dat4_7: mmc0_dat4_7 
{ +						atmel,pins =
> > 
> > +							<AT91_PIOC 10 
AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/*
> > MCI0_DB1, conflict with NAND_D5 */
> 
> Ok, so here also, the error comes from the comment: it's MCI0_DA4 up
> to MCI0_DA7.
> 
> The "A" stands for "slot 0" that you would instantiate in your board's
> .dts

Yep, I fixed this as well.

> > +							 AT91_PIOC 11 
AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/*
> > MCI0_DB2, conflict with NAND_D6 */ +						
	 AT91_PIOC 12
> > AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with
> > NAND_D7 */ +							 
AT91_PIOC 13 AT91_PERIPH_B AT91_PINCTRL_PULL_UP
> > /* MCI0_DB3, conflict with NAND_D8 */ +						
	>; +					}; };
> > 
> > mmc1 {
> 
> So Marek, you can send a v2 of this patch or I can do these changes if
> you prefer, tell me.

V2 is on it's way once I test the fixes briefly.

Best regards,
Marek Vasut
