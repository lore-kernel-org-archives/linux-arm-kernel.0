From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Dec 2013 13:55:38 -0800
Subject: [PATCH v5] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <20131212212811.GD12238@pengutronix.de>
References: <1386694516-5876-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131212011505.GD21856@quad.lixom.net>
 <20131212212811.GD12238@pengutronix.de>
Message-ID: <CAOesGMgdd+guHqrCwVjRd+zQ_-LtUb+0XAwCLeD+hL++NgssTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 1:28 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Dec 11, 2013 at 05:15:05PM -0800, Olof Johansson wrote:
>> On Tue, Dec 10, 2013 at 05:55:16PM +0100, Uwe Kleine-K?nig wrote:
>> > There are still some missing parts (e.g. board support, device trees),
>> > but with these bits added on top of this patch I can successfully boot a
>> > EFM32GG-DK3750 board that uses an EFM32GG990F1024.
>> >
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> > ---
>> > Hello,
>> >
>> > I'd like to get this patch in for 3.14. The latest submission (v4,
>> > Message-Id:1383562853-17202-4-git-send-email-u.kleine-koenig at pengutronix.de)
>> > had some strict dependencies:
>> >  - http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1
>> >    to be able to drop Makefile.boot, this is still in Status=Incoming in
>> >    rmk's patch tracker.
>> >  - http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7890/1
>> >    to be able to drop the unused <mach/entry-macro.S>. This is already
>> >    applied by rmk in his for-next branch, so it's not stable yet.
>> >  - My series to drop <mach/timex.h> for !MULTI_PLATFORM. I'll send a
>> >    pull request for that soon.
>> >  - Patch "clocksource: time-efm32: Select CLKSRC_MMIO". This is part of
>> >    a pull request by Daniel Lezcano that is expected to hit Linus T.'s
>> >    tree for the next -rc. It currently sits as
>> >    4ff3774e451fefb1781638c76230b3cf9a206b92 in Daniel's tree at
>> >    git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/fixes
>> >    .
>> >
>> > To make application a bit easier I added dummy files to drop the
>> > dependencies on the first three items of the list above.
>> >
>> > So it would be great if you could apply this patch when 4ff3774e4 went
>> > in. (In case you want to apply it already now, this last dependency
>> > could be work arounded, too, by adding a "select CLKSRC_MMIO" to
>> > ARCH_EFM32.)
>> >
>> > Other than that the only change since v4 is that I mention the exact
>> > board/processor combo in the changelog now.
>> >
>> > Thanks for considering this patch, best regards
>>
>> Applied to next/soc with a slightly tweaked patch subject.
> Thanks, but I wonder if it's a problem that the commit doesn't build? (i.e.
>
>         git checkout f9b9cef1329c74607f33a20dce3f26e9a1f4ae96
>         make efm32_defconfig
>         make
>
> fails in
>
>  - arch/arm/kernel/sigreturn_codes.S with
>    "Error: selected processor does not support ARM opcodes" and a few
>    variations.
>  - drivers/clocksource/time-efm32.o fails to link, because next/soc
>    isn't a decendant of 4ff3774e451f.
>
> You can fix the latter by adding "select CLKSRC_MMIO" to ARCH_EFM32 if
> you want. I don't remember what is the current state of the first
> problem.)

Ok, dropped the patch again. Please let us know when the former has
been resolved.


-Olof
