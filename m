From: moon9124@samsung.com (Daein Moon)
Date: Fri, 08 Oct 2010 15:02:17 +0900
Subject: No subject
Message-ID: <000201cb66ae$5caa04e0$15fe0ea0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben Dooks and Kukjin,

I found an issue about s3c_gpio_getpull API.

The 'plat-samsung' provides 's3c_gpio_setpull' and 's3c_gpio_getpull'
to set and get pull-{none|up|down} of GPIO. But there is no
's3c_gpio_getpull' definition in 'arch/arm/plat-samsung/gpio-config.c',
and there is only declaration in the corresponding header file.

's3c_gpio_getpull' isn't supported/used. So if providing this api, its
definition should be inserted.

Otherwise, code that is used to provide s3c_gpio_getpull including
following code should be removed.

arch/arm/plat-samsung/include/plat/gpio-cfg.h:
	extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);

arch/arm/mach-{s3c*|s5p*}/gpiolib.c:
        .get_pull       = s3c_gpio_getpull_updown,


What do you think about that?

Best Regards,
Daein Moon
