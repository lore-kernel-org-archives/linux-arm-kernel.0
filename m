From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 19 Sep 2016 17:53:02 +0200
Subject: [GIT PULL 1/3] ARM: soc: exynos: Drivers for v4.9
In-Reply-To: <2663426.T8oUku18qe@wuerfel>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
 <1474216788-17282-2-git-send-email-krzk@kernel.org>
 <2663426.T8oUku18qe@wuerfel>
Message-ID: <20160919155302.GA4447@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 05:02:40PM +0200, Arnd Bergmann wrote:
> On Sunday, September 18, 2016 6:39:46 PM CEST Krzysztof Kozlowski wrote:
> > Samsung drivers/soc update for v4.9:
> > 1. Allow compile testing of exynos-mct clocksource driver on ARM64.
> > 2. Document Exynos5433 PMU compatible (already used by clkout driver and more
> >    will be coming soon).
> 
> Pulled into next/drivers, thanks
> 
> Just for my understanding: why do we need the exynos-mct driver on ARM64
> but not the delay-timer portion of it?

I think we want all of it but Doug's optimization 3252a646aa2c
("clocksource: exynos_mct: Only use 32-bits where possible") is not
ARM64 friendly. One way of dealing with it would be to prepare two
versions of exynos4_read_current_timer(). One reading only lower 32-bit
value for ARMv7 and second (slow) reading lower and upper for ARMv8.

> 
> Is there an advantage in using MCT over the architected timer on these
> chips? If so, should we also have a way to use it as the delay timer?

No, there is no real advantage... except that the SoC has some
interesting "characteristics"... The timers are tightly coupled. Very
tightly. I spent a lot of time and failed to boot my ARMv8 board without
some MCT magic.

Best regards,
Krzysztof
