From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 16 Apr 2015 18:08:08 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable shmobile r8a7778 (M1A)
In-Reply-To: <552FDD73.70805@cogentembedded.com>
References: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <552FDD73.70805@cogentembedded.com>
Message-ID: <CAMuHMdW4=ZA5STuUm1zBypRtfuQtrD=2rBDW5GBGRS--zGMbzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 6:04 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 04/16/2015 06:08 PM, Ulrich Hecht wrote:
>
>> Also enables RTC (RX8581) and camera (ML86V7667) drivers as modules.

I think this is identical to
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327624.html?

>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>
>
>> diff --git a/arch/arm/configs/multi_v7_defconfig
>> b/arch/arm/configs/multi_v7_defconfig
>> index 06075b6..212199a 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>
> [...]
>>
>> @@ -500,6 +502,7 @@ CONFIG_RTC_DRV_SUN6I=y
>>   CONFIG_RTC_DRV_SUNXI=y
>>   CONFIG_RTC_DRV_MV=y
>>   CONFIG_RTC_DRV_TEGRA=y
>> +CONFIG_RTC_DRV_RX8581=m
>
>    The other RTC drivers seem to be built-in.

The current trend is to make "non-core" functionalities modular, to
reduce kernel size.

Yes, this means many of the existing options should be changed from
y to m.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
