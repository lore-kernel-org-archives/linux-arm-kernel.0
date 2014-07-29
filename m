From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 29 Jul 2014 11:23:20 +0530
Subject: [PATCH v7 6/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
In-Reply-To: <53CA72CC.7010505@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
 <1405345118-4269-7-git-send-email-thomas.ab@samsung.com>
 <53CA72CC.7010505@gmail.com>
Message-ID: <CAJuA9agfpQ7oyfZ99qSDj7EbsFk6dMnxxu5=P=vJYzTpAAUEuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Sat, Jul 19, 2014 at 6:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
> On 14.07.2014 15:38, Thomas Abraham wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Exynos4210 and Exynos5250 based platforms have switched over to use generic
>> cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
>> drivers for these platforms can be removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Arjun K.V <arjun.kv@samsung.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   22 ----
>>  drivers/cpufreq/Makefile             |    2 -
>>  drivers/cpufreq/exynos4210-cpufreq.c |  184 -----------------------------
>>  drivers/cpufreq/exynos5250-cpufreq.c |  210 ----------------------------------
>>  4 files changed, 418 deletions(-)
>>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
>>
>
> I would hesitate with removing this driver straightaway and replacing it
> with a new one that isn't yet well tested. For at least one release I
> would keep the old code in place with the possibility of switching
> between old and new one in Kconfig.

The new drivers have been tested for three days on
Exynos4210/5250/5420 based boards. So I am fairly confident that there
will be no issues in switching to the generic drivers and the old
drivers have not been retained in the next version.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
