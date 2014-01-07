From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 07 Jan 2014 20:12:42 +0100
Subject: [PATCH] ARM: s3c24xx: fix build error
In-Reply-To: <1389119245-2167-1-git-send-email-linus.walleij@linaro.org>
References: <1389119245-2167-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <22410027.ZzM9gppO8W@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. Januar 2014, 19:27:25 schrieb Linus Walleij:
> When enabling device tree on the S3C an additional build
> bug appears in the Osiris DVS board file:
> 
> CC  arch/arm/mach-s3c24xx/mach-osiris-dvs.o
> archh/arm/mach-s3c24xx/mach-osiris-dvs.c:
> In function ?osiris_dvs_notify?:
> arch/arm/mach-s3c24xx/mach-osiris-dvs.c:77:4:
> error: implicit declaration of function ?S3C2410_GPB?
> [-Werror=implicit-function-declaration]
>     gpio_set_value(OSIRIS_GPIO_DVS, 1);
>     ^
> 
> Fix this by explicitly including
> <linux/platform_data/gpio-samsung-s3c24xx.h>
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I have tentatively applied this to the GPIO tree so I
> don't cause build regressions, ACKs are still
> appreciated from the S3C maintainers.

Acked-by: Heiko Stuebner <heiko@sntech.de>
