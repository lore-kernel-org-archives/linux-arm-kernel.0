From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 28 May 2013 23:47:15 -0700
Subject: [PATCH 0/2] clk: add of_clk_provider stubs to enable clk-si5351
 on non OF
In-Reply-To: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367369910-20402-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130529064715.6058.43702@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2013-04-30 17:58:27)
> Enabling drivers that provide clocks on DT on platforms that don't have
> CONFIG_OF set fails due to compilation errors. This patch set first adds
> some stubs for of_clk_provider functions if CONFIG_OF is not set. Second
> it allows those platforms to build and use clk-si5351 i2c clock driver
> by removing the dependency on CONFIG_OF.
> 
> The above approach has been suggested by Arnd Bergmann and replaces the
> corresponding Kconfig patch for clk-si5351 posted earlier. It has been
> compile tested with allmodconfig on x86_64 for post v3.9.
> 
> Sebastian Hesselbarth (2):
>   clk: add non CONFIG_OF routines for clk-provider
>   clk: si5351: Allow to build without CONFIG_OF
> 

Both are taken into clk-next.

Thanks,
Mike

>  drivers/clk/Kconfig          |    1 -
>  include/linux/clk-provider.h |   47 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 9 deletions(-)
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Marek Belisko <marek.belisko@streamunlimited.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> -- 
> 1.7.10.4
