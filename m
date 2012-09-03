From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 13:01:00 +0000
Subject: [PATCH 1/4] ARM: ks-8695: merge the timer header into the timer
 driver
In-Reply-To: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
References: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201209031301.00691.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 August 2012, Linus Walleij wrote:
> +#define KS8695_TMR_OFFSET      (0xF0000 + 0xE400)
> +#define KS8695_TMR_VA          (KS8695_IO_VA + KS8695_TMR_OFFSET)
> +#define KS8695_TMR_PA          (KS8695_IO_PA + KS8695_TMR_OFFSET)

I'm not too happy about KS8695_TMR_VA moving into a device driver, but aside
from that the patch looks ok to me. Apparently, the gpio, ethernet, serial
and watchdog drivers for this platform already do it like this anyway.

	ARnd
