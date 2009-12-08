From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Dec 2009 11:23:51 +0100
Subject: dream: glue for mmc controller
In-Reply-To: <20091108091009.GB20529@n2100.arm.linux.org.uk>
References: <20091103105319.GA2492@elf.ucw.cz>
	<20091103105737.GE20341@fluff.org.uk>
	<20091108081314.GA16482@elf.ucw.cz>
	<20091108091009.GB20529@n2100.arm.linux.org.uk>
Message-ID: <20091208102351.GG12264@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-11-08 09:10:10, Russell King - ARM Linux wrote:
> On Sun, Nov 08, 2009 at 09:13:14AM +0100, Pavel Machek wrote:
> > > > +#include <asm/io.h>
> > > > +#include <asm/gpio.h>
> > > linux/gpio.h
> > > linux/io.h
> > 
> > I got compile errors when trying to use linux/gpio.h:
> > 
> > arch/arm/mach-msm/board-dream-gpio.c: In function
> > 'dream_gpio_configure':
> > arch/arm/mach-msm/board-dream-gpio.c:109: error: 'GPIOF_OUTPUT_LOW'
> > undeclared (first use in this function)
> 
> This means it's abusing the gpio header files - which are intended for
> the generic GPIO support, but are being used for this platforms private
> non-generic GPIO based stuff.

Ok, will fix.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
