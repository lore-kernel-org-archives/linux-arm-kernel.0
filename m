From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 31 Oct 2016 15:29:12 -0600
Subject: [PATCH] ARM: mediatek: clean up mach-mediatek/Makefile
In-Reply-To: <CAK7LNAQbaQ38RZqgmJJW+BHOthrK5tPZ5JPPh9N9ry58YZ=kdg@mail.gmail.com>
References: <1474222273-23116-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQbaQ38RZqgmJJW+BHOthrK5tPZ5JPPh9N9ry58YZ=kdg@mail.gmail.com>
Message-ID: <37560e04-fedd-57b7-4a99-812dd6d76cf7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/31/2016 07:15 AM, Masahiro Yamada wrote:
> Hi Matthias,
>
>
> Can you pick up this for your next pull request?
>

Sure, pushed to v4.9-next/kconfig

Next time please don't forget to send your patches to the mediatek 
mailinglist:
linux-mediatek at lists.infradead.org

This makes it easier for me to track the patches.

Thanks,
Matthias

>
>
> 2016-09-19 3:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Kbuild descends into arch/arm/mach-mediatek/Makefile only when
>> CONFIG_ARCH_MEDIATEK is enabled.  So, obj-$(CONFIG_ARCH_MEDIATEK)
>> is always equivalent to obj-y in this Makefile.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm/mach-mediatek/Makefile | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
>> index 2116460..dadae67 100644
>> --- a/arch/arm/mach-mediatek/Makefile
>> +++ b/arch/arm/mach-mediatek/Makefile
>> @@ -1,4 +1,2 @@
>> -ifeq ($(CONFIG_SMP),y)
>> -obj-$(CONFIG_ARCH_MEDIATEK) += platsmp.o
>> -endif
>> -obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
>> +obj-$(CONFIG_SMP)      += platsmp.o
>> +obj-y                  += mediatek.o
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
