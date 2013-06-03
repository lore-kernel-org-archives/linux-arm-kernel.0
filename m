From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 15:28:07 +0200
Subject: [PATCH] drivers/bus: arm-cci: fix combined ARMv6+v7 build
In-Reply-To: <alpine.LFD.2.03.1306030922380.1200@syhkavp.arg>
References: <2485806.Uv8bUctxav@wuerfel>
 <alpine.LFD.2.03.1306030922380.1200@syhkavp.arg>
Message-ID: <9496903.tJWqnjnUVv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 09:23:58 Nicolas Pitre wrote:
> On Mon, 3 Jun 2013, Arnd Bergmann wrote:
> 
> > When we build a kernel with support for both ARMv6 and ARMv7,
> > gas is trying to be helpful by pointing out that the arm-cci
> > driver would not work on ARMv6:
> > 
> > /tmp/ccu1LDeU.s: Assembler messages:
> > /tmp/ccu1LDeU.s:450: Error: selected processor does not support ARM mode `wfi '
> > /tmp/ccu1LDeU.s:451: Error: selected processor does not support ARM mode `wfe '
> > make[4]: *** [drivers/bus/arm-cci.o] Error 1
> > 
> > We know that the driver will only be used on ARMv7, hence we
> > can annotate the inline assembly listing to allow those instructions.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks

> Since this code is merged into ARM-SOC, I assume you'll take care of 
> this patch?

Yes, I applied it on top of the next/soc branch now.

	Arnd
