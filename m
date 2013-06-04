From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Jun 2013 09:25:27 +0800
Subject: [PATCH v3 11/11] ARCH: mmp: support clocksource in timer
In-Reply-To: <51ACCD65.8030204@linaro.org>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-12-git-send-email-haojian.zhuang@gmail.com>
 <51ACCD65.8030204@linaro.org>
Message-ID: <CAN1soZwdc1jEK7t2kLHMNdRr+79vKwQRQxnTV0c9Nu1MOu_qcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 1:07 AM, John Stultz <john.stultz@linaro.org> wrote:
> On 06/03/2013 02:30 AM, Haojian Zhuang wrote:
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index f151c6c..f429f68 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -72,6 +72,12 @@ config CLKSRC_METAG_GENERIC
>>         help
>>           This option enables support for the Meta per-thread timers.
>>   +config CLKSRC_MMP
>> +       def_bool y if ARCH_MMP
>> +       select CLKSRC_OF if OF
>> +       help
>> +         This option enables support for the MMP timer.
>> +
>>   config CLKSRC_EXYNOS_MCT
>>         def_bool y if ARCH_EXYNOS
>>         help
>>
>
> If I'm reading the above right, CONFIG_CLKSRC_MMP is identical to
> CONFIG_ARCH_MMP, no?
>
> Why not just use CONFIG_ARCH_MMP for configuration conditional code (and
> have that config select CLKSRC_OF if appropriate)?
>
> Otherwise we just start adding extra unnecessary config options that really
> don't add any real meaning to things.
>
> thanks
> -john
>
>
>
It's also OK. I can remove it.

Regards
Haojian
