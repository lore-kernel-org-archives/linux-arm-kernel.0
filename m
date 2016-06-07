From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 7 Jun 2016 17:50:44 +0100
Subject: shared resources in AMP between Cortex-A9 and Cortex-M4
In-Reply-To: <20160607162545.GX26768@pengutronix.de>
References: <20160607162545.GX26768@pengutronix.de>
Message-ID: <5756FB64.6060207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/06/16 17:25, Uwe Kleine-K?nig wrote:
> Hello Stefan,
>
> I'm currently trying to get Linux running on the M4 of an i.MX6 Solo X
> and found you describing doing this on the Vybrid already[1].
>
> I see the problem that clk and pinmux must be used by both cores. Did
> you solve this for your Vybrid experiments? And if so, how did it work?
>
> Having two drivers on the same IP is racy at best and using some kind of
> inter cpu communication to let (say) the A9 enable the clks for the M4
> sounds like overkill.
>

IMO it should be other way around. In-fact few latest platforms(with
performant Cortex-A cores) have dedicated Cortex-M core to do such
system control and power management as it are low power and mostly
always on.

-- 
Regards,
Sudeep
