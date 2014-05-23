From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Sat, 24 May 2014 02:44:30 +0400
Subject: [PATCH v10 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <537FB995.5070604@gmail.com>
References: <1400841343-6016-1-git-send-email-t.dakhran@samsung.com>
 <1400841343-6016-2-git-send-email-t.dakhran@samsung.com>
 <537FB995.5070604@gmail.com>
Message-ID: <CANhyOUd8Q2nzh_bF6LZNuv8keVUB3F45PocYrLP_B=D_Q3tWuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomazs,

On Sat, May 24, 2014 at 1:11 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Tarek,
>
> With v2 of the series I mentioned in review of previous version [1],
> this patch can be skipped.
>
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg31258.html
>
> Best regards,
> Tomasz
>
> On 23.05.2014 12:35, Tarek Dakhran wrote:
[snip]
>> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
>> index 739bdc8..971baf0 100644
>> --- a/arch/arm/mach-exynos/firmware.c
>> +++ b/arch/arm/mach-exynos/firmware.c
>> @@ -50,7 +50,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>>
>>       boot_reg = sysram_ns_base_addr + 0x1c;
>>
>> -     if (!soc_is_exynos4212())
>> +     if (!soc_is_exynos4212() && !soc_is_exynos5410())
>>               boot_reg += 4*cpu;
>>
>>       __raw_writel(boot_addr, boot_reg);
>>

I need to define SoC type to set correct bootreg in firmware,
otherwise only one cpu can be booted.
So, this stuff is needed.

Best regards,
     Tarek
