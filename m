From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 12:43:54 +0100
Subject: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
In-Reply-To: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <5095037A.2020503@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> AM33XX has only one usable timer in the WKUP domain.
> Currently the timer instance in WKUP domain is used
> as the clockevent and the timer in non-WKUP domain
> as the clocksource. The timer in WKUP domain can keep
> running in suspend from a 32K clock and hence serve
> as the persistent clock. To enable this, interchange
> the timers used as clocksource and clockevent for
> AM33XX.

Doesn't this also mean that you won't get timer wakeups
in idle?  Or are you keeping the domain where the clockevent is
on during idle?

Kevin
