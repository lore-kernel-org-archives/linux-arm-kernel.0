From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 19 Apr 2013 22:37:36 +0200
Subject: [PATCH] cpufreq: exynos: allow disabling cpufreq drivers
In-Reply-To: <201304192059.38606.arnd@arndb.de>
References: <201304191554.29679.arnd@arndb.de> <51717623.2060709@samsung.com>
 <201304192059.38606.arnd@arndb.de>
Message-ID: <5171AB10.5070702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 08:59 PM, Arnd Bergmann wrote:
> Maybe you just didn't have CPUFREQ enabled? I also didn't notice this
> bug at first because it is turned off in the defconfigs.

I certainly had it enabled. Since I remember I needed to turn it off
temporarily after someone has introduced an incorrect change to the clock
tree definition and cpufreq was unexpectedly switching parents of one of
the root clocks at run time, which was causing malfunction of the camera
image processing chain.

Anyway this wasn't a clean mainline kernel, as there have been recently lot
of stuff pending upstream needed to have complete system with dt support.
I assume after 3.10 release the situation is going to be much better.

> It could also be working by chance on EXYNOS4, since the register
> definitions were not actually removed from the regs-clk.h header
> for those.

That's most likely what happened.


Thanks,
Sylwester
