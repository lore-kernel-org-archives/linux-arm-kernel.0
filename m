From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Aug 2018 12:42:27 +0200
Subject: [PATCH 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO
 descriptor
In-Reply-To: <20180820181333.2527-2-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180820181333.2527-2-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdb7E7cjZuYx6Cgxv2sNJmxvwqg0dNh3WpALwtnuCsezuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't request MODEM IRQ GPIO by its global number in
> ams_delta_modem_init().  Instead, obtain its GPIO descriptor
> and assign related IRQ to the MODEM.  Do that from
> omap_gpio_deps_init(), where the chip is already looked up.  Then, in
> ams_delta_modem_init(), just check for the IRQ number having been
> already assigned.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's a bit unorthodox to have the board files intercept and poke
around inside the gpio_chip like the code in this file does,
I prefer to keep it encapsulated inside the GPIO driver.
However this is the lesser evil... if OMAP1 is ever phased
over to device tree it will go away, until then it is just nicely
contained.

Yours,
Linus Walleij
