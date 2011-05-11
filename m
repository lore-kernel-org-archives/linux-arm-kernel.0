From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 May 2011 08:22:57 +0200
Subject: [PATCH] [wip] ARM: imx: register "leds-gpio" device using new
	helper function
In-Reply-To: <0D753D10438DA54287A00B027084269764D2C3CCBE@AUSP01VMBX24.collaborationhost.net>
References: <20110510073152.GF29089@pengutronix.de>
	<1305017456-10910-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<0D753D10438DA54287A00B027084269764D2C3CCBE@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110511062257.GH29089@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hartley,

On Tue, May 10, 2011 at 05:26:18PM -0500, H Hartley Sweeten wrote:
> On Tuesday, May 10, 2011 1:51 AM, Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > index fa5288018..3479f66 100644
> > --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> > @@ -113,7 +113,7 @@ eukrea_mbimx27_keymap_data __initconst = {
> >  	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
> >  };
> >  
> > -static struct gpio_led gpio_leds[] = {
> > +static const struct gpio_led gpio_leds[] __initconst = {
> >  	{
> >  		.name			= "led1",
> >  		.default_trigger	= "heartbeat",
> > @@ -128,19 +128,11 @@ static struct gpio_led gpio_leds[] = {
> >  	},
> >  };
> >  
> > -static struct gpio_led_platform_data gpio_led_info = {
> > +static const struct gpio_led_platform_data gpio_led_info __initconst = {
> >  	.leds		= gpio_leds,
> >  	.num_leds	= ARRAY_SIZE(gpio_leds),
> >  };
> 
> Just a note that the 'const' you added to struct gpio_led above will be
> discarded in struct gpio_led_platform_data.  You will get something like:
> 
> arch/arm/mach-imx/eukrea_mbimx27-baseboard.c:132: warning: initialization discards qualifiers from pointer target type
It seems you don't have

	9517f92 (leds: make *struct gpio_led_platform_data.leds const)

(contained in .39-rc1) in your tree :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
