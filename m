From: johnstul@us.ibm.com (John Stultz)
Date: Wed, 18 Jul 2012 20:57:32 -0700
Subject: [PATCH v9 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <alpine.LFD.2.02.1207182120180.9293@xanadu.home>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341588221-3822-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50074B32.8090607@us.ibm.com>
 <alpine.LFD.2.02.1207182120180.9293@xanadu.home>
Message-ID: <500785AC.4000404@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 06:41 PM, Nicolas Pitre wrote:
> On Wed, 18 Jul 2012, John Stultz wrote:
>
>> I'm also not a huge fan of adding clockevent drivers to drivers/clocksource/.
>>
>> Further, LinusW and I have different opinions on this (and its not that huge
>> of an issue), but I'd really prefer to see additions to drivers/clocksource be
>> only for clocksources that are likely to be shared *between architectures*.
> This is contrary to the push we've made for about 2 years now. We
> decided it is more beneficial to gather drivers according to their
> purpose and not according to the architecture they belong to.  The
> reason is that it is far easier to abstract common functionality if
> those drivers are close by.
>
>> Similarly, I'd prefer architecture specific clocksources (like TSC on x86,
>> timebase on ppc, etc) stay in the arch subdir, just so theirs a clear
>> ownership of the driver (ie: if in 10 years specific hw support is dropped
>> from the arch directory, we don't end up with zombie drivers that live on
>> because generic driver maintainers don't know what hardware they're actually
>> connected to).
> The same argument was said about cpufreq drivers, and cpuidle drivers,
> and IRQ controller drivers, etc.  They ended up in a common directory
> anyway.  In the end this helps generic driver maintainers because you
> don't end up with the same infrastructure copied over and over, each
> time with slight alteration, making any common API maintenance a
> nightmare.
>
> Zombie drivers shouldn't be a huge issue when no one selects their
> kconfig symbol.  On the other hand, drivers burried under various
> architecture directories are hard to maintain and abstract (ask tglx
> about his IRQ driver changes).
>
>> (But I'm somewhat flexible on this last point, as long as there really is a
>> chance it might be shared at some point)
> I think that common purpose is more important a criteria than
> sharability.  It's hard to say in advance if a piece of code might be
> shared or not.  On the other hand, its purpose should be rather clear.

Alright, alright,  I'll just grumble along with it then. :)
-john
