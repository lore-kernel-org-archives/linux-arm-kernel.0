From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 3 Mar 2016 13:27:59 +0100
Subject: [RFC 08/15] rtc: at91sam9: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <2233190.1BxevBAvDE@wuerfel>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-9-git-send-email-k.kozlowski@samsung.com>
 <2233190.1BxevBAvDE@wuerfel>
Message-ID: <CAMuHMdXUdz0=n2+Aa74f1LtwiwfV9=gkPBiJKC_DMyr1_jBe7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 11:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 03 March 2016 17:03:34 Krzysztof Kozlowski wrote:
>> index 0da40e2e4280..5c530b6b125d 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -1302,6 +1302,7 @@ config RTC_DRV_AT91RM9200
>>  config RTC_DRV_AT91SAM9
>>         tristate "AT91SAM9 RTT as RTC"
>>         depends on ARCH_AT91 || COMPILE_TEST
>> +       depends on HAS_IOMEM    # For MFD_SYSCON
>>         select MFD_SYSCON
>>         help
>>           Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
>>
>
> This is technically correct, but the entire RTC menu is hidden
> inside of 'depends on !UML && !S390', so we won't ever get there
> on any configuration that does not use HAS_IOMEM.
>
> If we did, all other RTC drivers would also fail.

So UML has no RTC. Should/can it use RTC_DRV_GENERIC?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
