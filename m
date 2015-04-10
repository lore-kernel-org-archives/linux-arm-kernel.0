From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 22:59:52 +0200
Subject: [PATCH v2] arm: zynq: Fix system clock with multi_v7_defconfig
In-Reply-To: <1d6383c8-de0d-474b-a824-d1402b40391f@BY2FFO11FD035.protection.gbl>
References: <550F6EDA.30709@adapteva.com> <7398185.8qW42GIbsU@wuerfel>
 <1d6383c8-de0d-474b-a824-d1402b40391f@BY2FFO11FD035.protection.gbl>
Message-ID: <7916396.UBTtkSpjzN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015 13:41:34 S?ren Brinkmann wrote:
> On Fri, 2015-04-10 at 10:04PM +0200, Arnd Bergmann wrote:
> > I've just had another idea: how about introducing a new compatible string
> > for the global timer that gets used for timers that have their frequency
> > tied to the CPU (alternatively a bool property in that node). This can
> > be checked by the clocksource driver, which will then be able to either
> > skip the device if cpufreq is in use, or implement a more sophisticated
> > workaround.
> 
> If this is the only available clocksource, you'd still want to use it
> though. A bad clocksource is still better than none. But I guess that
> would just mean to lie in the DT.

On zynq, you always have a local time, right?

If we get a platform that has no reliable clocksource, it's probably
time to implement scaling in the global timer driver.

	Arnd
