From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 23:26:18 +0200
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <CAL85gmD017shZfHGvewyH5FO9vsSFSNGo=vTL68sosvuvODa_A@mail.gmail.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
 <20140630125339.GA21390@leverpostej>
 <CACRpkdZ18SsRBBbngSVyxR0GFkC0kLD4OHm9RJmgZDLXbqvOBQ@mail.gmail.com>
 <CAL85gmD017shZfHGvewyH5FO9vsSFSNGo=vTL68sosvuvODa_A@mail.gmail.com>
Message-ID: <CACRpkdbt+sj_Htjrj4+hm6KHJfONpTSQyz25Hepkx5kugaO3AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 7, 2014 at 8:52 PM, Feng Kan <fkan@apm.com> wrote:
> On Fri, Jul 4, 2014 at 2:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> I don't get this either. The only reason would be that this cell
>> should contain flags (such as open collector) the code for using
>> it being inplemented later.
>
> Yes, open drain configuration and mux via pinctrl was something I
> planned for later.

OK but pinctrl is something else. There is also the GPIO
OD configuration, as it modifies the behaviour of how to set
GPIO lines.

(Yes I know the frameworks maybe ought to talk to each other
for such things....)

So if you plan to do this, add it to the bindings even if you're not
adding the code for handling it right now.

> There was another reason for this as well, part of the gpio code I read
> was confusing me. So I look through the other gpio documentations and
> found an example that did this as well.
>
> int of_gpio_simple_xlate(struct gpio_chip *gc,
>                          const struct of_phandle_args *gpiospec, u32 *flags)
> {
>         /*
>          * We're discouraging gpio_cells < 2, since that way you'll have to
>          * write your own xlate function (that will have to retrive the GPIO
>          * number and the flags from a single gpio cell -- this is possible,
>          * but not recommended).
>          */

Hm yeah that's right.

This check was added by Anton in 2008. Anton why did we discourage
onecell GPIOs?

Yours,
Linus Walleij
