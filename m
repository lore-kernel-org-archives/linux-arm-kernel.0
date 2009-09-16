From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 16 Sep 2009 12:34:36 +0200
Subject: [PATCH 2.6.31] ixp4xx: timer and clocks cleanups
In-Reply-To: <m3fxandg3z.fsf@intrepid.localdomain>
References: <200909102259.n8AMx7dB014927@pilspetsen.it.uu.se>
	<m3fxandg3z.fsf@intrepid.localdomain>
Message-ID: <19120.48956.449806.444089@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa writes:
 > Mikael Pettersson <mikpe@it.uu.se> writes:
 > 
 > > This patch does a few simple cleanups of the ixp4xx timer
 > > and clocksource/clockevent code in mach-ixp4xx/common.c:
 > >
 > > - ixp4xx_clocksource_init() is static and always returns 0,
 > >   which is ignored by its only caller: make it return void
 > > - ixp4xx_clockevent_init(): ditto
 > > - ixp4xx_get_cycles() is only referenced locally: make it static
 > > - use the ixp4xx_timer_irq.dev_id field to pass &clockevent_ixp4xx
 > >   to ixp4xx_timer_interrupt() via its dev_id parameter, allowing
 > >   the code in ixp4xx_timer_interrupt() to be smaller and faster
 > 
 > Thanks.

Great. Do you want to push these two patches via git or should
I add your Acked-by and submit them to the patch system?

/Mikael
