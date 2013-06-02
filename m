From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 Jun 2013 21:23:51 +0200
Subject: [PATCH] ARM: nomadik: fix clocksource warning
In-Reply-To: <41518453.ApMFpK6n11@wuerfel>
References: <41518453.ApMFpK6n11@wuerfel>
Message-ID: <CAKnu2Mq1iELz4virvp8wFbCw7T5ozOJA8GH9CARej=aHkRHvsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/31 Arnd Bergmann <arnd@arndb.de>:

> The clocksource API has changed slightly, which causes a harmless
> warning:
>
> /git/arm-soc/drivers/clocksource/nomadik-mtu.c:259:28: warning: 'nmdk_timer_match' defined but not used [-Wunused-variable]
>  static struct of_device_id nmdk_timer_match[] __initconst = {
>                             ^
>
> Fortunately, the same API change also lets us simplify the code
> while removing the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ah so it matches the string directly in CLOCKSOURCE_OF_DECLARE()
OK makes perfect sense, sometimes it's hard to keep up with
the evolutional pace here...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
