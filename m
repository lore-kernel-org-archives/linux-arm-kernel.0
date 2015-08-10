From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 11:29:58 +0200
Subject: [PATCH 1/6] gpiolib-of: Rename gpio_hog functions to be generic
In-Reply-To: <1438680203-13432-2-git-send-email-mpa@pengutronix.de>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYpeoo2scKzNuSYbWfWLTBodXJEX3KyRzoRQPuoaeqzKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The gpio hogging functions are currently only used for gpio-hogging. But
> these functions are widely generic ones which parse gpio device nodes in
> the DT.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
(...)
>  /**
> - * of_get_gpio_hog() - Get a GPIO hog descriptor, names and flags for GPIO API
> + * of_parse_gpio() - Get a GPIO hog descriptor, names and flags for GPIO API

It's not a good name, too generic. It could easily be assued this is
for something
wider.

of_parse_own_gpio() or something, indicating that this pertains to the
chip itself and not to outside users, would be better.

Yours,
Linus Walleij
