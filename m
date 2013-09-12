From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 12 Sep 2013 17:39:34 +0530
Subject: [PATCH RFC 0/6] ARM: OMAP2+: AM43x/AM335x prcm reset driver
In-Reply-To: <1378717612.4151.6.camel@pizza.hi.pengutronix.de>
References: <cover.1378129416.git.afzal@ti.com>
 <1378375634.3948.10.camel@pizza.hi.pengutronix.de> <5228A99D.4020702@ti.com>
 <1378717612.4151.6.camel@pizza.hi.pengutronix.de>
Message-ID: <5231AEFE.5000206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Monday 09 September 2013 02:36 PM, Philipp Zabel wrote:

> So if I understand correctly, the only problem is that on OMAP the clock
> needs to be enabled to deassert the reset, but as long as the clock
> domain is in hardware supervised mode, it won't be enabled?

Yes, enabling clock with reset deassertion might not reset the module if
the clock domain is in hardware supervised mode.

> Would it be possible to create an internal API to switch the clock
> domain to software supervised mode, which can be used both by the code
> behind pm_runtime_get_sync and reset_control_deassert?

I will see if that is acceptable.

Another option that would have to be explored is invoking device_reset()
(taking care of clear, deassert & status checking as you suggested)
midway through pm_run_time_get_sync(), when the clockdomain is in
software supervised mode with reset driver taking care of any particular
sequence in the case of multiple reset signals, instead of the IP driver
requiring to take care of it.

Regards
Afzal
