From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jan 2015 15:18:16 +0100
Subject: [PATCH 1/4] pinctrl: Broadcom Cygnus pinctrl device tree binding
In-Reply-To: <54C1EEF3.4040406@broadcom.com>
References: <rjui@broadcom.com>
 <1417131990-17954-1-git-send-email-rjui@broadcom.com>
 <1417131990-17954-2-git-send-email-rjui@broadcom.com>
 <CACRpkdb5pNMbXmWGjrGpAYNLLwv6pWWOJQy0C6BLetNcStFM6A@mail.gmail.com>
 <54B01D44.5080601@broadcom.com>
 <CACRpkdbW5P=w0CPYYf_gfBuD7W0WOdAYCKpTXM5MsK9mdYDc5w@mail.gmail.com>
 <54C1AE9F.3020407@broadcom.com> <54C1EEF3.4040406@broadcom.com>
Message-ID: <CACRpkdYq7svYkg-zadA-vd0tG=--5pre4PBrzitqNwj6VwPYMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 7:49 AM, Ray Jui <rjui@broadcom.com> wrote:

> I dig into the pinctrl framework code a bit more and found that I can
> use pinctrl_request_gpio from the GPIO driver and implement
> gpio_request_enable in the pinctrl driver.

Yep :) ain't it nice.

> The only problem I see now is that these APIs seem to expect the use of
> global GPIO numbers?

No they don't, only if you use the deprecated pinctrl_add_gpio_range().

Instead, when you register your struct gpio_chip, use
gpiochip_add_pin_range() and this will use relative offsets
without relying on global GPIO numbers.

This latter call replaces pinctrl_add_gpio_range().

> I hope I'm not missing something here?

You're missing gpiochip_add_pin_range() ;)

Yours,
Linus Walleij
