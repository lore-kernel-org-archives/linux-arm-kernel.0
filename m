From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 11:29:12 +0200
Subject: GPIO sysfs : set a wake source
In-Reply-To: <87fvxwia0s.fsf@free.fr>
References: <87fvxwia0s.fsf@free.fr>
Message-ID: <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 2:59 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> I was thinking on how to remove all "gpio_request()" from my board code
> (arch/arm/mach-pxa/mioa701.c).
>
> I have a small difficulty with the functionality provided by gpiolib in
> userspace. This is what I need :
>  - define a gpio as an input
>  - define this gpio to be an interrupt source
>  - define this interrupt to be a wake-up source

This sounds like trying to remove board code by moving it to userspace
and basically starting to implement stuff that belongs in the kernel
in userspace just because someone says we should get rid of board
files :-)

Don't go down this path, let the kernel handle this kind of stuff.

Instead figure out how to make the subsystems we have and the
device trees express what you want to do.

In another thread I suggested that we add a GPIO "hogging"
mechanism to gpiolib, so that the gpio subsystem can by itself
"hog" (get) some GPIOs and set them up in certain modes.
This closely matches what the pin control subsystem will do
with some such things.

What do you think about this idea?

Yours,
Linus Walleij
