From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 10:46:36 +0200
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120709084032.GF11635@S2101-09.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091018.25979.marex@denx.de>
 <20120709084032.GF11635@S2101-09.ap.freescale.net>
Message-ID: <201207091046.36886.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

[...]

> > Drop the pwm3 stuff, it's not used.
> 
> Okay.  I saw the following in mach-m28evk.c, and thought it's being
> used by backlight.  But you knows it better than me.

Well ... the support for that board that's in current mainline is pretty 
deprecated. And I wasn't really able to update it due to all the DT hype, you 
know the rest of the story more then well etc. etc.

> static const iomux_cfg_t m28evk_pads[] __initconst = {
> 	...
>         /* Backlight */
>         MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
> };
> 
> > > +			pinctrl at 80018000 {
> > > +				pinctrl-names = "default";
> > > +				pinctrl-0 = <&hog_pins_a>;
> > > +
> > > +				hog_pins_a: hog-gpios at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x30a3 /*
> > 
> > MX28_PAD_AUART2_CTS__GPIO_3_10 */
> > 
> > > +						0x30b3 /*
> > 
> > MX28_PAD_AUART2_RTS__GPIO_3_11 */
> 
> These two were copied from your initial m28evk DTS file, which says
> GPIO_3_10 is used as wp-gpios of mmc0 and GPIO_3_11 is used as
> phy-reset-gpios of fec.

Ah. Leave them there then. Just checked, they're correct.

> > > +						0x3103 /*
> > 
> > MX28_PAD_PWM0__GPIO_3_16 */
> > 
> > > +						0x3113 /*
> > 
> > MX28_PAD_PWM1__GPIO_3_17 */
> 
> From what mach-m28evk.c tells, they are used as m28evk_leds.

There're no leds on the thing that are controlled by GPIOs.

[...]

> > > +	else if (of_machine_is_compatible("denx,m28evk"))
> > > +		m28evk_init();
> > 
> > I think you need to call imx28_evk_init() here ?
> 
> Eh, why?

To start the enet_out clock.

[...]

Best regards,
Marek Vasut
