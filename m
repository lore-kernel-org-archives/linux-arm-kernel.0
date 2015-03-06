From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Mar 2015 09:26:26 +0100
Subject: [PATCH] RFC: let gpiod_get_optional et all return NULL when
 GPIOLIB is not enabled
In-Reply-To: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdb6KcZx3WfTqUKemhQ0_OsqxBGQb_P5cXXZvgc3riakdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 10:03 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> I wonder if gpiod_get_optional et all should be changed to return NULL
> instead.

This is actually the norm in most subsystems returning cookie
pointers, clk, regulator, pinctrl... a NULL pointer is a functional
noop. But normally then NULL is returned from all stubs, not
just optional.

Alexandre, what do you say?

> The obvious downside is that if the device tree specifies a
> reset-gpio and the kernel just fails to use it because there is some
> code missing, this should better be an error. (The adau1977 code has
> this problem already know, but when changing devm_gpiod_get_optional all
> callers are affected.)

Device Tree-specific problems is not something we design
subsystems for, we try to just accomodate them. I'm not
sure I fully understand what you mean here.

Yours,
Linus Walleij
