From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 16 Oct 2013 09:08:17 +0800
Subject: [PATCH v10 2/7] ARM: hi3xxx: add board support with device tree
In-Reply-To: <201310152006.38824.arnd@arndb.de>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <201310151500.36959.arnd@arndb.de>
 <CAD6h2NR6umVpgYM2t2pwrwP8-Jk-e3Kfng-7oymPJ44cNmuk-w@mail.gmail.com>
 <201310152006.38824.arnd@arndb.de>
Message-ID: <CAD6h2NRvCdfNef_q=6JyNvv2ZsObmwmh=wgcKu=j6RokE3-sFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2013 02:06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 October 2013, Haojian Zhuang wrote:
>> On 15 October 2013 21:00, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 15 October 2013, Haojian Zhuang wrote:
>> >>
>> >> Add board support with device tree for Hisilicon Hi3620 SoC platform.
>> >>
>> >> Changelog:
>> >> v10:
>> >> 1. Add .map_io() & debug_ll_io_init() back. Since debug_ll_io_init() is
>> >> only called if .map_io() isn't assigned. Use .map_io() to setup static
>> >> IO mapping that is used in clock driver.
>> >>
>> >
>> > This seems like a step in the wrong direction. Why would you want to use
>> > a static I/O mapping in the clock driver?
>> >
>>
>> Because Stephen & Kevin asked me to use unit address in DTS file. They
>> also require me to use reg property to present real hardware address
>> in DTS file.
>
> Ah, so it's just an optimization, not required to make the clock driver
> work, I misread that. Can you add a comment near the hi3620_io_desc
> definition and verify that it still works without it?
>
Yes, it can work without the IO table. The IO table could save a lot
of virtual address space for IO mapping.

> I would also recommend to extend that static mapping to the entire
> 0xfc800000-0xfcbfffff range, or whatever you can use to get the most
> I/O devices with a small number of TLB entries.
>
>         Arnd

OK. I'll extend the static mapping to the entire range.

Regards
Haojian
