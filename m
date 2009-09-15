From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 15 Sep 2009 23:59:12 +0200
Subject: [PATCH 2.6.31] ixp4xx: timer and clocks cleanups
In-Reply-To: <200909102259.n8AMx7dB014927@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Fri, 11 Sep 2009 00:59:07 +0200 (MEST)")
References: <200909102259.n8AMx7dB014927@pilspetsen.it.uu.se>
Message-ID: <m3fxandg3z.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> This patch does a few simple cleanups of the ixp4xx timer
> and clocksource/clockevent code in mach-ixp4xx/common.c:
>
> - ixp4xx_clocksource_init() is static and always returns 0,
>   which is ignored by its only caller: make it return void
> - ixp4xx_clockevent_init(): ditto
> - ixp4xx_get_cycles() is only referenced locally: make it static
> - use the ixp4xx_timer_irq.dev_id field to pass &clockevent_ixp4xx
>   to ixp4xx_timer_interrupt() via its dev_id parameter, allowing
>   the code in ixp4xx_timer_interrupt() to be smaller and faster

Thanks.
-- 
Krzysztof Halasa
