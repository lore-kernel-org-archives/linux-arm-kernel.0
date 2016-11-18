From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 18 Nov 2016 08:47:49 +0200
Subject: [PATCH] ARM: Drop fixed 200 Hz timer requirement from Exynos
 platforms
In-Reply-To: <3145378.USf2WOPoV2@wuerfel>
References: <1479148025-469-1-git-send-email-krzk@kernel.org>
 <3145378.USf2WOPoV2@wuerfel>
Message-ID: <20161118064749.GA2122@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 01:35:45PM +0100, Arnd Bergmann wrote:
> On Monday, November 14, 2016 8:27:05 PM CET Krzysztof Kozlowski wrote:
> > @@ -1497,7 +1497,7 @@ source kernel/Kconfig.preempt
> >  config HZ_FIXED
> >         int
> >         default 200 if ARCH_EBSA110 || ARCH_S3C24XX || \
> > -               ARCH_S5PV210 || ARCH_EXYNOS4
> > +               ARCH_S5PV210
> >         default 128 if SOC_AT91RM9200
> >         default 0
> 
> After further research, I've concluded that we should also drop the
> settings for ARCH_S5PV210 and ARCH_S3C24XX here.
> 
> ARCH_S5PV210 behaves exactly like EXYNOS here, it has 32-bit timers
> so there won't be any overflow with 100Hz.
> 
> For ARCH_S3C24XX, it the requirement was that HZ_100 could not
> be used with the old arch/arm/plat-samsung/time.c code that would
> overflow its 16-bit counter.
> However, the new drivers/clocksource/samsung_pwm_timer.c configures
> the clock divider to '50' instead of '6', so there is no longer
> a 16-bit overflow before the 100Hz tick, it now overflows every
> 3.7ms for the typical 12MHz clock.

I can send an updated version however testing would be nice... I know
Sylwester has a S3C6410 platform running, maybe S3C24xx as well.

Best regards,
Krzysztof
