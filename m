From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Dec 2009 21:44:57 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <4B27F075.5000908@bluewatersys.com>
References: <4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9E6@mi8nycmail19.Mi8.com>
	<20091215194725.GH24406@elf.ucw.cz>
	<4B27F075.5000908@bluewatersys.com>
Message-ID: <20091215204457.GM24406@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-12-16 09:24:21, Ryan Mallon wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> >>> +int gpio_to_irq(unsigned gpio)
> >>> +{
> >>> +	return -EINVAL;
> >>> +}
> >> This should probably just be an inline function in
> >> arch/arm/mach-msm/include/mach/gpio.h
> > 
> > Well, it is not performance critical in any way and it is likely to
> > change in future. I'd leave it here.
> 
> If this function eventually does do something interesting, it would be
> useful to have it as a macro in arch/arm/mach-msm/include/mach/gpio.h
> since it can be used for static/define declarations, ie:
> 
> #define SOME_GPIO_IRQ gpio_to_irq(SOME_GPIO)

gpio_to_irq is defined as a function in Doc*/gpio.txt.

> >> static inline int irq_to_gpio(unsigned irq)
> >> {
> >> 	return -EINVAL;
> >> }
> > 
> > I'd say that would be overdoing it.
> 
> You should implement this if you have gpio_to_irq because it is part of
> the API, see include/linux/gpio.h

I'm implementing it. I just don't want to implement two inline
functions instead of one normal function.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
