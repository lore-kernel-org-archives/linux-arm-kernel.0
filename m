From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 13 Dec 2013 11:30:13 +0100
Subject: [PATCH 1/2] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
References: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <12061693.IYmMzIp37Y@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thursday 12 of December 2013 15:06:50 Linus Walleij wrote:
[snip]
>  arch/arm/mach-s3c64xx/include/mach/gpio.h          |  93 -----------------

Hmm, shouldn't this (and other s3c64xx-related changes) be in patch 2/2?

Anyway, I've applied both, but unfortunately compilation for mach-s3c64xx
(using s3c6400_defconfig) fails with following error:

  CC      arch/arm/plat-samsung/pm-gpio.o
In file included from arch/arm/plat-samsung/pm-gpio.c:25:0:
arch/arm/plat-samsung/include/plat/gpio-core.h:100:44: error: 'S3C_GPIO_END' undeclared here (not in a function)
 extern struct samsung_gpio_chip *s3c_gpios[S3C_GPIO_END];
                                            ^
scripts/Makefile.build:308: recipe for target 'arch/arm/plat-samsung/pm-gpio.o' failed
make[1]: *** [arch/arm/plat-samsung/pm-gpio.o] Error 1
Makefile:820: recipe for target 'arch/arm/plat-samsung' failed
make: *** [arch/arm/plat-samsung] Error 2

I don't have much time right now to look at this further, but I'll try
to do it later today (if you don't fix it before that) and do further
testing.

Best regards,
Tomasz
