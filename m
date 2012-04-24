From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 24 Apr 2012 16:50:58 -0700
Subject: New ARM build coverage (was: linux-next: triage for April 18,
 2012)
In-Reply-To: <201204201759.52271.arnd@arndb.de>
References: <CAP=VYLrNpskLQDAw3Udnq7grddi-uD6TDjQQoZUd+FVg2rXPnA@mail.gmail.com>
 <201204201759.52271.arnd@arndb.de>
Message-ID: <4F973C62.6070102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> On Thursday 19 April 2012, Paul Gortmaker wrote:
>> ARM folks,
>>
>> Just a heads up that Stephen expanded the linux-next ARM coverage
>> today to add a whole bunch more builds.
>>
>> Possibly "new" build fails were detected in these configs:
>>
>> ARM:mackerel_defconfig,ag5evm_defconfig
>> ARM:ezx_defconfig
>> ARM:mini2440_defconfig
>
> I think this is needed to fix mini2440_defconfig after the platform
> files have been moved around.
>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
>
> diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
> index 42da918..082175c 100644
> --- a/arch/arm/configs/mini2440_defconfig
> +++ b/arch/arm/configs/mini2440_defconfig
> @@ -14,6 +14,8 @@ CONFIG_MODULE_FORCE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
>   CONFIG_BLK_DEV_INTEGRITY=y
>   CONFIG_ARCH_S3C24XX=y
> +# CONFIG_CPU_S3C2410 is not set
> +CONFIG_CPU_S3C2440=y
>   CONFIG_S3C_ADC=y
>   CONFIG_S3C24XX_PWM=y
>   CONFIG_MACH_MINI2440=y

I tested and it's ok to me.
Thanks, Will apply.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
