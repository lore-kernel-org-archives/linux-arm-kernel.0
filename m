From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Apr 2015 15:23:14 +0900
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <19177883.oJbWsfhyVG@wuerfel>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
 <3196164.8b31S2QWFd@wuerfel>
 <CAK7LNATkYVwT337okeW=c1NjyxB4ovXKSNzxtTwk7XXGN45z7w@mail.gmail.com>
 <19177883.oJbWsfhyVG@wuerfel>
Message-ID: <CAK7LNATHJF0qgQvhw=A2gdgTwhL9aCUjM_=kUR5RohzOKq8fQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-04-07 21:22 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 07 April 2015 17:22:32 Masahiro Yamada wrote:
>> Hi Arnd,
>>
>> Thanks for your comment!
>>
>> 2015-04-07 16:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Tuesday 07 April 2015 12:34:30 Masahiro Yamada wrote:
>> >>
>> >> What is the cause of the kernel panic?  How to fix it?
>> >> Any hint is very appreciated.
>> >>
>> >
>> > Cortex-A9 usually need to set up the L2 Cache controller, and you
>> > don't have a node for that.
>> >
>> > Can you try adding a DT node for it? You may also have to specify
>> > the overrides for its aux control register in DT if that is not
>> > set up right by the boot loader or the power-on defaults.
>>
>> I have not checked the L2 (outer) cache yet.
>>
>> The L2 cache on our SoC is not a famous IP, but our own implementation.
>> I will have to implement L2 code as well as the device tree node.
>> Is there any workaround to boot Linux without L2 cache?
>
> It should work normally, I think the only dangerous combination is
> when the L2 controller is enabled but not configured correctly.

OK, I must check this area.

> It's also quite likely that there is some other problem with your
> user space image. Are you able to boot the same image inside of
> qemu or on another hardware that is supported with multi_v7_defconfig?

Yes, I have a Zynq Zedboard.

It successfully boots Linux with the same kernel image and initramdisk.



-- 
Best Regards
Masahiro Yamada
