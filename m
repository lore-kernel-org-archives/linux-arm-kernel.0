From: alchark@gmail.com (Alexey Charkov)
Date: Wed, 14 Nov 2012 15:22:54 +0400
Subject: arch-vt8500 and wm8850 support
In-Reply-To: <201211141117.33485.arnd@arndb.de>
References: <1352879641.2728.8.camel@gitbox> <201211141117.33485.arnd@arndb.de>
Message-ID: <CABjd4YypF3u+kTqN5ghUxFsNhR5ZJ4UuHJy_4D=4MS1=KM6v7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/14 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 14 November 2012, Tony Prisk wrote:
>> Hi Arnd,
>>
>> Just looking for a little advice re: adding support for the WM8850
>> variant.
>>
>> At the moment we have the ARM926 variants under ARCH_VT8500. The WM8850
>> is ARMv7, but uses all the same drivers as the ARM926 versions. At the
>> moment, all the drivers depend on ARCH_VT8500.
>>
>> The obvious solution (to me at least) seems to be to have 3 groups -
>> ARCH_VT8500 keeps everything it has now except 'select CPU_ARM926T', and
>> we add 2 additional groups - the first for all the current models, which
>> selects CPU_ARM926T and ARCH_VT8500, and a second for WM8850 which
>> selects CPU_V7 and ARCH_VT8500.
>
> Yes, makes sense. Actually with the move to multiplatform, you already
> need to make the decision for the CPU earlier on, since the multiplatform
> kernel can only be built either for ARMv4/v5 or for ARMv6/v7.
>
> I would suggest doing it like
>
> config ARCH_VT8500
>         bool
>         select FOO
>         select BAR
>
> config ARCH_WM8505
>         bool "WonderMedia WM8505 or VIA VT8500"
>         depends on ARCH_MULTI_V5
>         select ARCH_VT8500
>         select CPU_ARM926
>
> config ARCH_WM8650
>         bool "WonderMedia WM 8650"
>         depends on ARCH_MULTI_V6
>         select ARCH_VT8500
>         select CPU_V6
>
> config ARCH_WM8850
>         bool "WonderMedia WM 8750/8850"
>         depends on ARCH_MULTI_V7
>         select ARCH_VT8500
>         select CPU_V7

Just my 2 cents: from what I remember, 8650 is still v5, while 87xx is
v6 and 88xx+ are v7. The whole arrangement looks pretty neat, though,
thanks for your feedback!

Best,
Alexey
