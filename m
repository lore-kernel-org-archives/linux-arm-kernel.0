From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 7 Jul 2014 14:54:47 -0700
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <CACRpkdbt+sj_Htjrj4+hm6KHJfONpTSQyz25Hepkx5kugaO3AA@mail.gmail.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
 <20140630125339.GA21390@leverpostej>
 <CACRpkdZ18SsRBBbngSVyxR0GFkC0kLD4OHm9RJmgZDLXbqvOBQ@mail.gmail.com>
 <CAL85gmD017shZfHGvewyH5FO9vsSFSNGo=vTL68sosvuvODa_A@mail.gmail.com>
 <CACRpkdbt+sj_Htjrj4+hm6KHJfONpTSQyz25Hepkx5kugaO3AA@mail.gmail.com>
Message-ID: <20140707215446.GA28692@teo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 11:26:18PM +0200, Linus Walleij wrote:
...
> > There was another reason for this as well, part of the gpio code I read
> > was confusing me. So I look through the other gpio documentations and
> > found an example that did this as well.
> >
> > int of_gpio_simple_xlate(struct gpio_chip *gc,
> >                          const struct of_phandle_args *gpiospec, u32 *flags)
> > {
> >         /*
> >          * We're discouraging gpio_cells < 2, since that way you'll have to
> >          * write your own xlate function (that will have to retrive the GPIO
> >          * number and the flags from a single gpio cell -- this is possible,
> >          * but not recommended).
> >          */
> 
> Hm yeah that's right.
> 
> This check was added by Anton in 2008. Anton why did we discourage
> onecell GPIOs?

Yup, the check was there from the very beginning. Think of
OF_GPIO_ACTIVE_LOW flag (it is widely used in drivers.)

The documentation in Feng's driver says "second cell is used to specify
optional parameters (unused)," which is not entirely correct. With the
standard xlate call it is used for active-low flag. You can implement
active-low flag w/o using the second cell, but it will be ugly.

Thanks,

Anton
