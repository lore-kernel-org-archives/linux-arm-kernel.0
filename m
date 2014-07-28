From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 19:41:03 +0800
Subject: [PATCH v10 04/11] ARM: hisi: enable HiP04
In-Reply-To: <201407281308.49775.arnd@arndb.de>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-5-git-send-email-haojian.zhuang@linaro.org>
 <201407281308.49775.arnd@arndb.de>
Message-ID: <CAD6h2NTx5k0VuTiwkCSzyB9rvekvLLS0rp_sCLzoAwyKq0PaOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 July 2014 19:08, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 July 2014, Haojian Zhuang wrote:
>> --- a/arch/arm/mach-hisi/platmcpm.c
>> +++ b/arch/arm/mach-hisi/platmcpm.c
>> @@ -116,7 +116,6 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
>>                CORE_DEBUG_RESET_BIT(cpu);
>>         writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
>>         spin_unlock_irq(&boot_lock);
>> -       msleep(POLL_MSEC);
>>
>>         return 0;
>>  }
>
> Is this change intentional? It seems like it should belong into the earlier patch
> that introduces this file.
>
>         Arnd

Yes, it should belong to the earlier patch. And it's fixed in v12 or v13.

Regards
Haojian
