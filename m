From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 15:58:58 +0100
Subject: [PATCH 3/4] ARM: realview: imply Device Tree config
In-Reply-To: <2805017.I27kg8jfk6@wuerfel>
References: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
 <1456406111-18579-4-git-send-email-linus.walleij@linaro.org>
 <2805017.I27kg8jfk6@wuerfel>
Message-ID: <CACRpkdZCqNH-cuoXbZaJ2Uw5-0UvLZ+vo0Lz9Nq+7AaawEp6-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 25 February 2016 14:15:10 Linus Walleij wrote:
>> @@ -32,8 +24,9 @@ config REALVIEW_DT
>>         select USE_OF
>>         select ZONE_DMA
>
> The 'select USE_OF' can now be dropped, I guess this was left over
> from the multiplatform patches, but also fits in here.
>
>>         help
>> -         Include support for booting the ARM(R) RealView(R) evaluation
>> -         boards using a device tree machine description.
>> +         This enables support for ARM Ltd RealView boards.
>> +
>> +if ARCH_REALVIEW
>>
>>  config REALVIEW_HIGH_PHYS_OFFSET
>>         bool "High physical base address for the RealView platform"
>>
>
> REALVIEW_HIGH_PHYS_OFFSET can go away as well, as it is only used
> in 'realview_fixup', which in turn is called by the removed board
> files.

OK I updated the patch cutting these too.

Yours,
Linus Walleij
