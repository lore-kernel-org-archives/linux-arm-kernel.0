From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Apr 2014 09:42:04 -0700
Subject: [PATCH v3] gpio: omap: implement get_direction
In-Reply-To: <535911D0.3020907@ti.com>
References: <1398322659-20008-1-git-send-email-yegorslists@googlemail.com>
 <CACRpkdZPNGHNQhqovDoaKTXZT3mJfN4pjKSBxW7m6wT5u-XEYQ@mail.gmail.com>
 <535911D0.3020907@ti.com>
Message-ID: <20140424164204.GE22987@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140424 06:30]:
> On Thursday 24 April 2014 09:13 AM, Linus Walleij wrote:
> > On Thu, Apr 24, 2014 at 8:57 AM,  <yegorslists@googlemail.com> wrote:
> > 
> >> From: Yegor Yefremov <yegorslists@googlemail.com>
> >>
> >> This patch implements gpio_chip's get_direction() routine, that
> >> lets other drivers get particular GPIOs direction using
> >> struct gpio_desc.
> >>
> >> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> >> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> >> ---
> >> Changes:
> >>         v3: get rid of _get_gpio_direction() (Linus Walleij)
> >>         v2: rework return value calculation
> > 
> > Looks good to me, Kevin, Santosh?
> > 
> Looks fine to me as well.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

OK finally got around testing gpio/for-next here. Could not use
todays linux next as it's broken again for whatever reasons and
does not even compile for me.

Boot tested gpio/next on few omap1 boards: h2, osk and 770 and
things behave the same way as earlier for me on these boards.
Also made sure the PM does not break as tested on n900 with the
GPIO changes. So for the following patches, feel free to add:

cb2a5fb059b5 gpio: do not set up hardware for IRQ_TYPE_NONE
da09ceae78f7 gpio: omap: implement get_direction
d04b76626e94 gpio: omap: convert driver to use gpiolib irqchip
d4094cd7577c gpio: omap: check gpiochip_add() return value
820eade1b7f3 gpio: omap: convert to use irq_domain_add_simple()
717f70e39a98 gpio: omap: Use devm_ioremap_resource()

Tested-by: Tony Lindgren <tony@atomide.com>

Naturally no need to go back to edit the commits for my acks
unless there are other reasons to redo the branches.

> > Part of me wants to list Javier as maintainer for this driver.
> > 
> Am ok with it as well.

That sounds good to me too, looks like Javier is doing a good job
on that already :)

Regards,

Tony 
