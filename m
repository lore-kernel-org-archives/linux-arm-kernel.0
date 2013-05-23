From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 May 2013 16:10:04 +0200
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <20130523125033.GP18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
 <201305231409.02359.arnd@arndb.de>
 <20130523125033.GP18614@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 2:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 02:09:02PM +0200, Arnd Bergmann wrote:
>> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
>> > This is the problem you guys are missing - unreachable() means "we lose
>> > control of the CPU at this point".
>>
>> I'm absolutely aware of this. Again, the current behaviour of doing nothing
>> at all isn't very different from undefined behavior when you get when you
>> get to the end of a function returning a pointer without a "return" statement,
>> or when you return from a function that has determined that it is not safe
>> to continue.
>
> Running off the end of a function like that is a different kettle of fish.
> The execution path is still as the compiler intends - what isn't is that
> the data returned is likely to be random trash.
>
> That's _quite_ different from the CPU starting to execute the contents
> of a literal data pool.

I agree it's best to e.g. trap and reboot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
