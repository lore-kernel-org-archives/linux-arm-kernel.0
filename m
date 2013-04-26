From: horms@verge.net.au (Simon Horman)
Date: Fri, 26 Apr 2013 11:23:40 +0900
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <2538127.Zp8aiG0hQe@avalon>
References: <1366599990-31751-1-git-send-email-horms+renesas@verge.net.au>
 <1761228.8meccMO5Km@avalon> <20130423011524.GE12017@verge.net.au>
 <2538127.Zp8aiG0hQe@avalon>
Message-ID: <20130426022340.GA31993@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 12:48:03PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 23 April 2013 10:15:25 Simon Horman wrote:
> > On Mon, Apr 22, 2013 at 12:00:02PM +0200, Laurent Pinchart wrote:
> > > Hi Simon,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Monday 22 April 2013 12:06:30 Simon Horman wrote:
> > > > The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> > > > support them.
> > > > 
> > > > Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.
> > > > 
> > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > > 
> > > >  arch/arm/mach-shmobile/board-lager.c | 37 +++++++++++++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > > 
> > > > Tested on lager board.
> > > > Based on the tag renesas-next-20130419 of my renesas tree.
> > > > 
> > > > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > > > b/arch/arm/mach-shmobile/board-lager.c index 6114edd..a8aa04f 100644
> > > > --- a/arch/arm/mach-shmobile/board-lager.c
> > > > +++ b/arch/arm/mach-shmobile/board-lager.c
> > > > @@ -21,13 +21,49 @@
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/irqchip.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/leds.h>
> > > >  #include <linux/pinctrl/machine.h>
> > > > +#include <linux/platform_data/gpio-rcar.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <mach/common.h>
> > > >  #include <mach/r8a7790.h>
> > > >  #include <asm/mach-types.h>
> > > >  #include <asm/mach/arch.h>
> > > > 
> > > > +/* LEDS */
> > > > +static struct gpio_led lager_leds[] = {
> > > > +	{
> > > > +		.name		= "led8",
> > > > +		.gpio		= RCAR_GP_PIN(5, 17),
> > > > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> > > > +	}, {
> > > > +		.name		= "led7",
> > > > +		.gpio		= RCAR_GP_PIN(4, 23),
> > > > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> > > > +	}, {
> > > > +		.name		= "led6",
> > > > +		.gpio		= RCAR_GP_PIN(4, 22),
> > > > +		.default_state	= LEDS_GPIO_DEFSTATE_ON,
> > > 
> > > Just out of curiosity, why is the default state on ?
> > 
> > Only because thats what the marzen code does.
> > Would off be a better choice?
> 
> It would save a little bit of power by default :-)

:^)

I think that I would rather leave it _ON for consistency with
other shmobile board code.
