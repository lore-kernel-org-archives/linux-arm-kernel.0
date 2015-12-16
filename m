From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Dec 2015 10:27:53 +0900
Subject: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <20151216011110.GA13147@earth>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
 <1450215622-27394-3-git-send-email-eric@anholt.net>
 <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net>
 <5670AAB2.1080102@gmail.com> <87mvtbkyd0.fsf@eliezer.anholt.net>
 <20151216011110.GA13147@earth>
Message-ID: <CAJKOXPes85hu6Jnd5p6dqhgdBGF4kmZuJQekM73O83DuZvcyoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-16 10:11 GMT+09:00 Sebastian Reichel <sre@ring0.de>:
> Hi,
>
> On Tue, Dec 15, 2015 at 04:53:31PM -0800, Eric Anholt wrote:
>> >>> What motivated the location of this power domain driver in
>> >>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
>> >>> somewhere in drivers/ at the very least?
>> >>
>> >> ls stronly suggests that power contains drivers for power supplies and
>> >> batteries, not power domains.
>
> Indeed it's used for fuel gauges and chargers, but also for
> reboot/powerdown and adaptive voltage scaling, so another
> subdirectory for power-domains wouldn't be that odd.
>
>> >> There are 6 power domain drivers in
>> >> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
>> >
>> > If we ever have to support a different architecture which happens to use
>> > a similar power domain, then we want it to be in a location which makes
>> > it easy for sharing it in the first place. As it stands today, it does
>> > not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
>> >
>> > Maybe there is room from a drivers/power/domains/ of some kind?
>
> I like the idea, but let's include generic power domain maintainers
> in this discussion, as I suggested here (I got a power domain driver
> patch for drivers/power just a few days ago):
>
> https://lkml.org/lkml/2015/12/15/815
>
> Also somebody would have to step up to maintain that directory.

This could go into drivers/soc. We put there a lot of mach-specific
stuff which we want to make a little more generic (like generic enough
multiplatform, multiarchitecture etc). Rockchip has its own power
domains there. Dove and Mediatek seem as well but I am not sure. Some
other architectures keep this still in arm/mach (exynos, ux500, zx,
imx, s34c64xx, shmobile) but this looks more of like a legacy choice.

However, since generic power domains have its own maintainers entry
and reside under drivers/base/power, maybe making a separate directory
for power domains drivers makes sense?

Best regards,
Krzysztof
