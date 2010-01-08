From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 8 Jan 2010 08:28:26 +0000
Subject: [PATCH] gpiolib: add gpio_lookup_chip() to get chip
	information for gpio
In-Reply-To: <f17812d71001072330t7a9f7607v8b55b2fc346745e5@mail.gmail.com>
References: <1262932348-2888-1-git-send-email-ben-linux@fluff.org>
	<1262932348-2888-2-git-send-email-ben-linux@fluff.org>
	<f17812d71001072330t7a9f7607v8b55b2fc346745e5@mail.gmail.com>
Message-ID: <20100108082826.GC1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 03:30:36PM +0800, Eric Miao wrote:
> On Fri, Jan 8, 2010 at 2:32 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > Add a call to get the 'struct gpio_chip' pointer for a given gpio, so
> > that core implementations which want to use gpiolib gpio numbering for
> > things like mux configuration can get back to the gpio_chip that they
> > registered without having to have their own list of gpio.
> >
> > This is especially useful for the Samsung S3C64XX series where the GPIO
> > bank sizes can vary from 32 down to 3, making it difficult to store an
> > array to convert a number to chip.
> >
> 
> I think this is generally a good idea. Will most likely be useful to
> pxa platforms as well. Not sure though if you want to export this
> symbol as well since we do allow gpio chip drivers to be modules.

Probably not, since all the gpio call methods pass gpio_chip as their
first parameter. This is only in the case we want to use gpios for
something other than in/out/irq.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
