From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 20:58:54 +0100
Subject: [PATCH] drivers/pinctrl: grab default handles from device core
In-Reply-To: <20121212115828.GJ4398@game.jcrosoft.org>
References: <1355233246-16694-1-git-send-email-linus.walleij@stericsson.com>
 <20121211181336.GD25714@kroah.com>
 <20121212115828.GJ4398@game.jcrosoft.org>
Message-ID: <CACRpkdbWx+EOvwuO4j19gAbVwUKY+xHQSeoAwB4b-NOMiH4twQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 12:58 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

>> > +#ifdef CONFIG_PINCTRL
>> > +   struct dev_pin_info     pins;
>> > +#endif

> can do do not put ifdef in the struct as if will force us to put ifdef in the
> c code too instead of just use a inline function

Oh, I'm just planning to use this from the pinctrl core code itself
and the code in drivers/base/pinctrl.c (which is only compiled when
CONFIG_PINCTRL is set) so there is no risk for that right now.

I would agree if we exposed to drivers, like the dev_pm_ops...
but that's not the plan right now.

Yours,
Linus Walleij
