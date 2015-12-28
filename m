From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Dec 2015 12:54:28 +0100
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
In-Reply-To: <DB3PR04MB07407D83CC5F8F5F19A7207F4FB0@DB3PR04MB074.eurprd04.prod.outlook.com>
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
 <20151027081834.GB1425@svinekod>
 <DB3PR04MB07407D83CC5F8F5F19A7207F4FB0@DB3PR04MB074.eurprd04.prod.outlook.com>
Message-ID: <4875455.lvoc6XpkZc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 December 2015 07:18:58 Huan Wang wrote:
> Hi, Arnd,
> 
> 	Could you help to review the following patch? Thanks.
> 

Hi Alison,

I'm sorry but I understand very little of this particular area of the kernel.

I've added Daniel Lezcano, John Stultz and Thomas Gleixner to Cc, they all
know this much better than I do and one of them should be able to comment after
their Christmas break.

	Arnd

> > On Fri, Jul 17, 2015 at 10:11:52AM +0100, Alison Wang wrote:
> > > Hrtimer based broadcast is used on ARM platform. It can be registered
> > > as the tick broadcast device in the absence of a real external clock
> > > device.
> > >
> > > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > 
> > This looks sensible to me. FWIW:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Thanks,
> > Mark.
> > 
> > > ---
> > >  arch/arm/kernel/time.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c index
> > > a66e37e..a9bc73c 100644
> > > --- a/arch/arm/kernel/time.c
> > > +++ b/arch/arm/kernel/time.c
> > > @@ -12,6 +12,7 @@
> > >   *  reading the RTC at bootup, etc...
> > >   */
> > >  #include <linux/clk-provider.h>
> > > +#include <linux/clockchips.h>
> > >  #include <linux/clocksource.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/export.h>
> > > @@ -121,5 +122,7 @@ void __init time_init(void)
> > >  		of_clk_init(NULL);
> > >  #endif
> > >  		clocksource_of_init();
> > > +
> > > +		tick_setup_hrtimer_broadcast();
> > >  	}
> > >  }
