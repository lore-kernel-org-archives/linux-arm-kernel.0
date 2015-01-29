From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Jan 2015 10:24:18 +0100
Subject: [PATCH] leds: ipaq needs LEDS_CLASS
In-Reply-To: <7354226.f7e3npkAlC@wuerfel>
References: <7354226.f7e3npkAlC@wuerfel>
Message-ID: <CACRpkdZi9R8f+6cGz8cMmBTdvHpMu5SDG7qwbMvHXNFk=81g2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 9:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> All other drivers have a dependency on this already, but this one
> does not, which can lead to a link error when LEDS_CLASS is not set.
>
> drivers/built-in.o: In function `micro_leds_remove':
> :(.text+0x13d1bc): undefined reference to `led_classdev_unregister'
> drivers/built-in.o: In function `micro_leds_probe':
> :(.text+0x13d3d0): undefined reference to `led_classdev_register'
>
> This patch adds the missing dependency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry for screwing up...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
