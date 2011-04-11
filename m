From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 16:21:10 +0100
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <BANLkTi=bur3zPkQ45+StkPxLm_YMyw9uaw@mail.gmail.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<BANLkTi=bur3zPkQ45+StkPxLm_YMyw9uaw@mail.gmail.com>
Message-ID: <20110411152110.GC21449@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 05:17:53PM +0200, Linus Walleij wrote:
> 2011/4/11 Jamie Iles <jamie@jamieiles.com>:
> 
> > The basic-mmio-gpio driver has been extended in
> > <http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
> > larger wider of controllers and this series converts the ARM platforms
> > that do not implement I/O muxing in the GPIO driver or use the .to_irq
> > method of gpio_chip to use the driver.
> >
> > Jamie Iles (5):
> > ?gemini: convert to basic-mmio-gpio
> > ?sa1100: convert to basic-mmio-gpio
> > ?w90x900: convert to basic-mmio-gpio
> > ?iop: convert to basic-mmio-gpio
> > ?mxc: convert to basic-mmio-gpio
> 
> For all of these, maybe you can
>   select GPIO_BASIC_GPIO
> 
> In their mach-xxx/Kconfig so that the driver gets compiled-in by default?

OK, Uwe has suggested that already so I'll fix that up for the next 
attempt.

> Further the basic_mmio_gpio.c driver looks a bit dangerous: it only uses
> __raw_* accessors for the GPIO registers, I'd very much like to replace that
> with the non-__raw* versions if this is to have any generic impact.
> 
> The raw accessors can get stuck in things like write buffers and the like
> IIRC, they usually won't so you don't notice first, then you start getting
> all kind of real strange bugs.

Sounds sensible.  I'll create a patch to convert to use the non raw 
versions then.

Jamie
