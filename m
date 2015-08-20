From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 20 Aug 2015 14:44:49 +0200
Subject: [RFC PATCH 0/3] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <20150820070507.GS5161@pengutronix.de>
References: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
 <20150805073117.GP5161@pengutronix.de>
 <20150810065334.GC2635@odux.rfo.atmel.com>
 <20150820070507.GS5161@pengutronix.de>
Message-ID: <20150820124449.GB23434@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 09:05:07AM +0200, Sascha Hauer wrote:
> On Mon, Aug 10, 2015 at 08:53:34AM +0200, Ludovic Desroches wrote:
> > Hi Sascha,
> > 
> > On Wed, Aug 05, 2015 at 09:31:17AM +0200, Sascha Hauer wrote:
> > > On Fri, Jul 31, 2015 at 05:08:07PM +0200, Ludovic Desroches wrote:
> > > > Hi,
> > > > 
> > > > Following our discussion, I send an RFC version of my driver. RFC because it is
> > > > not totally achieved, some cleanup and feature addition is needed.
> > > > 
> > > > At least, we could discuss about the 'core' part. I have used the pinmux
> > > > property as Mediatek driver. Patch 3 is the internal dt files we are using.
> > > 
> > > As you can imagine I am fine with the binding, so I can add my acked-by
> > > once you send a non-RFC version.
> > >
> > 
> > Great, I'm glad to hear that.
> >  
> > > The only thing I never understood is what's so special about GPIOs that
> > > they have to bypass the pinctrl framework and instead a gpio_request
> > > magically translates a gpio into a pin.
> > 
> > Not sure to really understand your concern here... Do you mean I could
> > get rid of gpio_request_enable()?
> 
> I would expect a gpio to be a pin like every other pin, hence configured
> via the pinctrl framework and not implicitly via gpio_request().
> 

It is not an issue to get rid of gpio_request_*(). I was thinking it was
a bonus to provide it.

> > 
> > > Wouldn't it make sense to at
> > > least add the pins in their GPIO mode to
> > > arch/arm/boot/dts/sama5d2-pinfunc.h?
> > 
> > It is done, PIN_PA0 could be used for this purpose.
> 
> I would expect a define like:
> 
> #define PIN_PA3__GPIO                   PINMUX_PIN(PIN_PA3, 0, 2)
> 
> PIN_PAx only contains the pin number, but not the function.

Ok I can do this change for v2.


Ludovic
