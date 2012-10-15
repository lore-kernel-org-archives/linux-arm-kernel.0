From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 16 Oct 2012 00:04:05 +0400
Subject: [PATCH] gpio: clps711x: localise <mach/gpio.h> header
In-Reply-To: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
References: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121016000405.94f779c6066ded6289e35baa@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2012 21:40:20 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The commit adding the CLPS711x driver also added <mach/gpio.h>
> to the CLPS711x, and we want to get rid of all <mach/*>
> headers for the future. It turns out that the one macro defined
> in the file was only used in the GPIO driver itself, so just
> delete it and copy the macro into the driver.
...
> -/* Simple helper for convert port & pin to GPIO number */
> -#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
...

This macro is not used by driver and was be designed especially for future
easy modify existing drivers that use GPIO to gpio-driver.

-- 
Alexander Shiyan <shc_work@mail.ru>
