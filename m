From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Sep 2015 15:50:16 +0200
Subject: Build regressions/improvements in v4.3-rc3
In-Reply-To: <20150928094836.GU21513@n2100.arm.linux.org.uk>
References: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
 <20150928093006.GT21513@n2100.arm.linux.org.uk>
 <20150928094836.GU21513@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdU5UGfDSzfNWsZvsgLvJJYK-5VWEZ841Zc4GYfey6RdtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Sep 28, 2015 at 11:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 28, 2015 at 10:30:06AM +0100, Russell King - ARM Linux wrote:
>> On Mon, Sep 28, 2015 at 08:57:44AM +0200, Geert Uytterhoeven wrote:
>> > On Sun, Sep 27, 2015 at 9:34 PM, Geert Uytterhoeven
>> > <geert@linux-m68k.org> wrote:
>> > > JFYI, when comparing v4.3-rc3[1] to v4.3-rc2[3], the summaries are:
>> > >   - build errors: +8/-12
>> >
>> >   + error: No rule to make target include/config/auto.conf:  => N/A
>> >
>> > arm-randconfig
>>
>> Not every randconfig failure is a kernel problem.  Here's an example:
>>
>> Physical address of main memory (PHYS_OFFSET) [] (NEW) aborted!
>>
>> Console input/output is redirected. Run 'make oldconfig' to update configuration.
>>
>> This needs someone to provide a value, which means these failures are
>> not in fact failures of the kernel, but a failure of the build system
>> to anticipate that there may be Kconfig questions that need input.
>>
>> So, these ones should be ignored.

Usually I ignore them. But as this was the only failure to report (I ignore
R_PPC64_REL24 failures, too), I thought to kick the kbuild people (and the
ARM list, as it was the ARM randconfig that failed) for once.

> Also, a great many of the failures are due to the build toolchain not
> supporting -fstack-protector-strong.  I think it's absolutely right
> for the build to error out if you enable a kernel feature which requires
> toolchain support, but the toolchain does not support that feature.
>
> What this means is that the build results from kissb are less than
> useful - without spending ages looking at every single build, it's
> hard to find the real failures we care about.
>
> I'd suggest that either the randconfig is seeded to ensure that
> CONFIG_CC_STACKPROTECTOR_STRONG is always disabled in ARM randconfigs,
> or that the ARM toolchain is updated to support this feature.

Or that it's impossible to enable this feature if your toolchain doesn't
support it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
