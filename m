From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 15 Jul 2014 22:55:41 +0530
Subject: [PATCH] ARM: config: update multi_v7_defconfig
In-Reply-To: <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
References: <1405411346-12471-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
Message-ID: <CAHfPSqBuVWSCdJCv7xJ8UEpiq_GRiiL=OX6-u1KtZ-3jpRNTYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug

On 15 July 2014 21:29, Doug Anderson <dianders@chromium.org> wrote:
> Naveen,
>
> On Tue, Jul 15, 2014 at 1:02 AM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> Enabled S3C24XX I2C driver and MAX77686 PMIC MFD and Voltage
>> regulator drivers used on Exynos5250 based Snow board.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> ---
>> By enabling the symbols to compile S3C24XX I2C driver, MAX77686 PMIC
>> under MFD and REGULATOR.
>>
>> http://arm-soc.lixom.net/bootlogs/next/next-20140711/snow-multi_v7_defconfig.html
>> The warnings by cpufreq on Snow board are fixed.
>>
>> Booted and verified on  on Exynos5420 based Snow board
>>
>>  arch/arm/configs/multi_v7_defconfig |    3 +++
>>  1 file changed, 3 insertions(+)
>
> Is there a reason not to add more of the max77686 configs?

I was trying to address the warnings posted @
http://arm-soc.lixom.net/bootlogs/next/next-20140711/snow-multi_v7_defconfig.html

>
> +CONFIG_RTC_DRV_MAX77686=y
> +CONFIG_COMMON_CLK_MAX77686=y
>
> I also seems like it would be nice to reconcile this with Sacin's
> latest patch.  For starters I notice that you're missing:
>   CONFIG_EXYNOS5420_MCPM=y

Right
>
> I'll leave it up to you to look for other things that might be
> missing.  If some of the things in exynos5_defconfig can't go into the
> multi-config, please explain.

Will try to bring the symbols from Sachin's patch for exynos_defconfig
to multi_v7_defconfig.

>
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
(: Naveen :)
