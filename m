From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Aug 2012 10:01:38 +0100
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <502E5073.6000901@ti.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
 <502E5073.6000901@ti.com>
Message-ID: <20120820090138.GA25864@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 03:08:51PM +0100, Jon Hunter wrote:
> Hi Will, Tony,

Hi Jon [adding Arnd],

> On 08/10/2012 12:36 PM, Will Deacon wrote:
> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > index c00c689..02b9478 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -23,7 +23,6 @@
> >  #include <mach/irqs.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/map.h>
> > -#include <asm/pmu.h>
> >  
> >  #include "iomap.h"
> >  #include <plat/board.h>
> > @@ -448,7 +447,7 @@ static struct resource omap3_pmu_resource = {
> >  
> >  static struct platform_device omap_pmu_device = {
> >  	.name		= "arm-pmu",
> > -	.id		= ARM_PMU_DEVICE_CPU,
> > +	.id		= -1,
> >  	.num_resources	= 1,
> >  };
> 
> I know that I have already ack-ed the change and it is fine with me,
> however, I see a potential merge conflict here with my patch [1]
> (assuming that these all go into v3.7) where I am moving the above
> structure.

Are your patches queued anywhere other than your tree? If not, then I could
ask Arnd to pull the perf changes into their own branch in arm-soc and you
could rebase onto that.

> For testing I have rebased my series on top of this series and it is
> working well so far on OMAP4460.

Great, thanks. Can I add your tested-by to the patches please?

Will
