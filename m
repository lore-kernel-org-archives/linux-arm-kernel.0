From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 28 Aug 2012 22:13:46 +0200
Subject: [PATCH 0/3] Removal of obsolete s3c2410_* GPIO API
In-Reply-To: <503C03D7.5050801@samsung.com>
References: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
 <503C03D7.5050801@samsung.com>
Message-ID: <503D267A.2090406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2012 01:33 AM, Kukjin Kim wrote:
> On 08/25/12 05:20, Sylwester Nawrocki wrote:
>> This short patch series converts remaining users of the s3c24xx SoC
>> specific gpiolib functions to the gpiolib API and finally removes
>> all s3c2410_* functions from drivers/gpio/gpio-samsung.c.
>>
>> Sylwester Nawrocki (3):
>> ARM: S3C24XX: Convert users of s3c2410_gpio_setpin to gpiolib API
>> ARM: S3C24XX: Remove obsolete GPIO API declarations
>> gpio-samsung: Remove now unused s3c2410_gpio* API
>>
>> arch/arm/mach-s3c24xx/mach-anubis.c | 3 +-
>> arch/arm/mach-s3c24xx/mach-jive.c | 12 ++--
>> arch/arm/mach-s3c24xx/mach-mini2440.c | 4 +-
>> arch/arm/mach-s3c24xx/mach-nexcoder.c | 22 +++---
>> arch/arm/mach-s3c24xx/mach-osiris.c | 7 +-
>> arch/arm/plat-samsung/include/plat/gpio-fns.h | 97 
>> -------------------------
>> drivers/gpio/gpio-samsung.c | 40 ----------
>> 7 files changed, 25 insertions(+), 160 deletions(-)
>>
> 
> Nice cleanup.

Thanks for taking care of this whole series. 

I thought it needs to be done as we go adding more and more new 
code.. For time being it is my last GPIO cleanup patch series ;)

> Accordingly, we need to sort out the 
> 'Documentation/arm/Samsung-S3C24XX/GPIO.txt' later?

Indeed, I let this out for a moment. Let me tidy this up as well, when 
I find some time.


Thanks,
Sylwester

> Linus, this series should be sent to upstream via both trees, samsung 
> and gpio to avoid useless merge conflicts. How do you think?
> 
> Thanks.
> 
> Best regards,
> Kgene.
> -- 
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
