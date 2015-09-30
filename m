From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Sep 2015 10:22:46 +0200
Subject: [RFC/PATCH 00/11] arm: omap: counter32k rework
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Message-ID: <1986790.syN3WBv9AR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 September 2015 15:43:55 Felipe Balbi wrote:
> 
> the following patches de-obfuscate arch/arm/mach-omap2/timer.c
> and start moving code to drivers/clocksource. So far only counter32k
> has been moved over.
> 
> Note that we can't get rid of all the code (yet) because there are
> still platforms relying to legacy boot and because of the strong
> coupling with OMAP's hwmod layer.
> 
> This is, for now, an RFC and has be written on top of [1]. Boot tested
> with AM335x and AM437x.
> 
> [1] http://marc.info/?l=linux-omap&m=144354336924308&w=2

Looks very nice!

> ps: if anybody has a good idea on how to get rid of
> register_persistent_clock(), please let me know

I don't think we want to get rid of that, because it is the more
accurate interface. IIRC systems that have an RTC will use
timekeeping_inject_sleeptime64() in rtc_resume(). I don't know however
how the two methods are coordinated, i.e. how the kernel ensures that
exactly one of the two is used, but never both.

	Arnd
