From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 09:10:10 +0000
Subject: dream: glue for mmc controller
In-Reply-To: <20091108081314.GA16482@elf.ucw.cz>
References: <20091103105319.GA2492@elf.ucw.cz>
	<20091103105737.GE20341@fluff.org.uk>
	<20091108081314.GA16482@elf.ucw.cz>
Message-ID: <20091108091009.GB20529@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 09:13:14AM +0100, Pavel Machek wrote:
> > > +#include <asm/io.h>
> > > +#include <asm/gpio.h>
> > linux/gpio.h
> > linux/io.h
> 
> I got compile errors when trying to use linux/gpio.h:
> 
> arch/arm/mach-msm/board-dream-gpio.c: In function
> 'dream_gpio_configure':
> arch/arm/mach-msm/board-dream-gpio.c:109: error: 'GPIOF_OUTPUT_LOW'
> undeclared (first use in this function)

This means it's abusing the gpio header files - which are intended for
the generic GPIO support, but are being used for this platforms private
non-generic GPIO based stuff.

> arch/arm/mach-msm/board-dream-gpio.c:291: error: 'IRQF_TRIGGER_HIGH'
> undeclared (first use in this function)
> arch/arm/mach-msm/board-dream-gpio.c:293: error: implicit declaration
> of function 'set_irq_wake'

That's showing its missing a linux/interrupt.h include.
