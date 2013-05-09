From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 09 May 2013 14:59:47 +0200
Subject: GPIO sysfs : set a wake source
Message-ID: <87fvxwia0s.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I was thinking on how to remove all "gpio_request()" from my board code
(arch/arm/mach-pxa/mioa701.c).

I have a small difficulty with the functionality provided by gpiolib in
userspace. This is what I need :
 - define a gpio as an input
 - define this gpio to be an interrupt source
 - define this interrupt to be a wake-up source

In kernel, I had : gpio_request(), request_irq(), and gpio_set_wake() (in
mioa701, this ends up in gsm_on_irq()).

In userspace I have :
 - echo 113 > /sys/class/gpio/export
 - echo in > /sys/class/gpio/gpio113/direction
 - echo both > /sys/class/gpio/gpio113/edge

And here, I don't know how to trigger a call to gpio_set_wake(113, 1). Do you
provide that API somewhere in sysfs that I didn't find ? Because that's what I
need to obliterate gpio calls from my board code.

Cheers.

-- 
Robert
