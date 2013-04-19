From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 19 Apr 2013 23:12:13 +0200
Subject: [PATCH] cpufreq: exynos: allow disabling cpufreq drivers
In-Reply-To: <201304192243.30430.arnd@arndb.de>
References: <201304191554.29679.arnd@arndb.de>
 <201304192059.38606.arnd@arndb.de> <5171AB10.5070702@gmail.com>
 <201304192243.30430.arnd@arndb.de>
Message-ID: <5171B32D.6030601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 10:43 PM, Arnd Bergmann wrote:
> On Friday 19 April 2013, Sylwester Nawrocki wrote:
>>> It could also be working by chance on EXYNOS4, since the register
>>> definitions were not actually removed from the regs-clk.h header
>>> for those.
>>
>> That's most likely what happened.
>
> Ok. I think I see the bigger picture now. The EXYNOS5 cpufreq driver was
> actually just merged now, so I assume that by the time Thomas did the clock
> changes, the register definitions for EXYNOS5 were actually unused and he
> subsequently removed them from the kernel.
>
> Since the driver now depends on them, I think the only way forward for 3.10
> is to revert the change that removed the definitions and put them back in
> place.

Yes, it sounds like a best thing to do. I was also considering that.

> We really should use the clock API from all the exynos cpufreq drivers, but it's
> too late for that change now in 3.10 and we will have to do it for 3.11 then.

Yes, the changes required to make the cpufreq driver using the clocks 
API would
be rather significant.

> This are not looking so good for exynos multiplatform support in 3.10 now, but
> if we get it in, that will mean we have to disable cpufreq when building
> multiplatform, but it can remain for the classic single-platform configurations.

Alright, let's hope eventually we get at least a minimum booting system. ;)

Thanks,
Sylwester
