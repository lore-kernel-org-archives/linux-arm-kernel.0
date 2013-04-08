From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Apr 2013 10:11:30 -0600
Subject: GENERIC_GPIO considered deprecated
In-Reply-To: <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
References: <CAAVeFu+QUw1WmzwaJDfjyw75PrStd3p3PHs1MU5BC7_WXMB7kw@mail.gmail.com>
 <51576214.8010307@openwide.fr>
 <CAAVeFu++8YOOSxPbAaTudxSGcBomkGrakBjiVyD+XSee54TrWw@mail.gmail.com>
 <26e401ce30cc$602e45f0$208ad1d0$%kim@samsung.com>
 <CAAVeFuJcAgFma6wxmyoUN4Kfp-+y-gj3QMWvVYsCK_D8q0gSXQ@mail.gmail.com>
 <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
Message-ID: <5162EC32.2030602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 01:31 AM, Kukjin Kim wrote:
> Alexandre Courbot wrote:
>>
>> On Wed, Apr 3, 2013 at 5:35 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>> could you amend the patches that adds them such as they get changed
>>>> into "select ARCH_REQUIRE_GPIOLIB" instead? You can grep for "select
>>>
>>> I can do it for my tree but the branch already included in arm-soc tree
>> so I think, it should be fixed with another patch. And
>>>
>>>> GENERIC_GPIO" in arch/arm to find the offending lines. We are removing
>>>> GENERIC_GPIO and this work cannot be merged until you do this since it
>>>> would break ARM builds. Thanks!
>>>>
>>> So how about following? If you are OK, let me take into samsung tree.
>>>
>>> --------8<----------------8<--------
>>> From: Kukjin Kim <kgene.kim@samsung.com>
>>> Subject: [PATCH] ARM: SAMSUNG: change GENERIC_GPIO to
>> ARCH_REQUIRE_GPIOLIB
>>>
>>> When I applied regarding samsung-time patches, the "select GENERIC_GPIO"
>>> has been added wrong, so this patch fixes that.
>>> And since the GENERIC_GPIO in arch/arm/ will be gone away, this adds
>>> ARCH_REQUIRE_GPIOLIB for S3C24XX and S5PC100 instead.
>>>
>>> Reported-by: Alexandre Courbot <gnurou@gmail.com>
>>> Cc: Romain Naour <romain.naour@openwide.fr>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> ---
>>>  arch/arm/Kconfig |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 46fcfa8..a239c7e 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -770,10 +770,10 @@ config ARCH_SA1100
>>>  config ARCH_S3C24XX
>>>         bool "Samsung S3C24XX SoCs"
>>>         select ARCH_HAS_CPUFREQ
>>> +       select ARCH_REQUIRE_GPIOLIB
>>>         select CLKDEV_LOOKUP
>>>         select CLKSRC_MMIO
>>>         select GENERIC_CLOCKEVENTS
>>> -       select GENERIC_GPIO
>>>         select HAVE_CLK
>>>         select HAVE_S3C2410_I2C if I2C
>>>         select HAVE_S3C2410_WATCHDOG if WATCHDOG
>>> @@ -828,11 +828,11 @@ config ARCH_S5P64X0
>>>
>>>  config ARCH_S5PC100
>>>         bool "Samsung S5PC100"
>>> +       select ARCH_REQUIRE_GPIOLIB
>>>         select CLKDEV_LOOKUP
>>>         select CLKSRC_MMIO
>>>         select CPU_V7
>>>         select GENERIC_CLOCKEVENTS
>>> -       select GENERIC_GPIO
>>>         select HAVE_CLK
>>>         select HAVE_S3C2410_I2C if I2C
>>>         select HAVE_S3C2410_WATCHDOG if WATCHDOG
>>> --
>>> 1.7.10.4
>>
>> Should do the trick, if we can make sure that your tree is merged
>> prior to my patches.
> 
> I'm not sure but I think, arm-soc tree should be merged into mainline before others...
> 
>> Can you put it into your tree for 3.10?
>>
> I did, so it should be fine.
> 
> Thanks.
> 
> - Kukjin

You may want to discuss how to handle this dependency with the arm-soc
maintainers (CC'd).
