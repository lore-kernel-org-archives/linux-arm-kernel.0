From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2018 17:13:25 -0400
Subject: [PATCH v3 2/3] platform: move the early platform device support
 to arch/sh
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-3-brgl@bgdev.pl>
Message-ID: <CAK8P3a2Fn-QK6SzFTJCmrToSG2vyO2fZt47Bomqjq-sAe8s4-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2018 at 9:27 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
>
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I had not gotten around to look at this in enough detail so far, but
looking now, it seems all good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
