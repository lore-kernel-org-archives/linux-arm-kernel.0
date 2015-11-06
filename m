From: alison.wang@freescale.com (Huan Wang)
Date: Fri, 6 Nov 2015 06:35:06 +0000
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
In-Reply-To: <20151027081834.GB1425@svinekod>
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
 <20151027081834.GB1425@svinekod>
Message-ID: <BN3PR0301MB08677D6B591DD7E5BD7341D7FE280@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	Could you help to review this patch?

	Thanks.


Best Regards,
Alison Wang

> On Fri, Jul 17, 2015 at 10:11:52AM +0100, Alison Wang wrote:
> > Hrtimer based broadcast is used on ARM platform. It can be registered
> > as the tick broadcast device in the absence of a real external clock;
> > device.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 
> This looks sensible to me. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
> 
> > ---
> >  arch/arm/kernel/time.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c index
> > a66e37e..a9bc73c 100644
> > --- a/arch/arm/kernel/time.c
> > +++ b/arch/arm/kernel/time.c
> > @@ -12,6 +12,7 @@
> >   *  reading the RTC at bootup, etc...
> >   */
> >  #include <linux/clk-provider.h>
> > +#include <linux/clockchips.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/errno.h>
> >  #include <linux/export.h>
> > @@ -121,5 +122,7 @@ void __init time_init(void)
> >  		of_clk_init(NULL);
> >  #endif
> >  		clocksource_of_init();
> > +
> > +		tick_setup_hrtimer_broadcast();
> >  	}
> >  }
> > --
> > 2.1.0.27.g96db324
> >
