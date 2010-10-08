From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 15:50:07 +0900
Subject: missing definition of 's3c_gpio_getpull' function in
	'plat-samsung'
In-Reply-To: <000301cb66af$276b8960$76429c20$@com>
References: <000301cb66af$276b8960$76429c20$@com>
Message-ID: <00e301cb66b5$14ce28c0$3e6a7a40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daein Moon wrote:
> 
> Hi Ben Dooks and Kukjin,
> 
> I found an issue about s3c_gpio_getpull API.
> 
> The 'plat-samsung' provides 's3c_gpio_setpull' and 's3c_gpio_getpull'
> to set and get pull-{none|up|down} of GPIO. But there is no
> 's3c_gpio_getpull' definition in 'arch/arm/plat-samsung/gpio-config.c',
> and there is only declaration in the corresponding header file.
> 
> 's3c_gpio_getpull' isn't supported/used. So if providing this api, its
> definition should be inserted.
> 
> Otherwise, code that is used to provide s3c_gpio_getpull including
> following code should be removed.
> 
> arch/arm/plat-samsung/include/plat/gpio-cfg.h:
> 	extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
> 
> arch/arm/mach-{s3c*|s5p*}/gpiolib.c:
>         .get_pull       = s3c_gpio_getpull_updown,
> 
> 
> What do you think about that?
> 
Oh...you mean s3c_gpio_getpull()?
Yes right..there is no it in gpio-config.c..maybe missed.

Anyway...in this case, I think to add missed function is better.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
