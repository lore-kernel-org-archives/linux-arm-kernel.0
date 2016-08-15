From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2016 10:07:55 +0100
Subject: [PATCH v3 4/4] arm64: apply __ro_after_init to some objects
In-Reply-To: <20160815145303.71628c8b@xhacker>
References: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
 <1470988871-2799-5-git-send-email-jszhang@marvell.com>
 <20160812124344.GB21484@leverpostej>
 <20160815145303.71628c8b@xhacker>
Message-ID: <20160815090755.GA1426@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 15, 2016 at 02:53:03PM +0800, Jisheng Zhang wrote:
> On Fri, 12 Aug 2016 13:43:45 +0100 Mark Rutland wrote:
> > On Fri, Aug 12, 2016 at 04:01:11PM +0800, Jisheng Zhang wrote:
> > > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > > index 10ad8ab..c1ff7c2 100644
> > > --- a/arch/arm64/kernel/vdso.c
> > > +++ b/arch/arm64/kernel/vdso.c
> > > @@ -19,6 +19,7 @@
> > >   */
> > >  
> > >  #include <linux/kernel.h>
> > > +#include <linux/cache.h>
> > >  #include <linux/clocksource.h>
> > >  #include <linux/elf.h>
> > >  #include <linux/err.h>  
> > 
> > Nit: Could you please sort this list? Everything but <linux/kernel.h> is
> > already in order.

[...]

> Thanks a lot, all comments are addressed in v4.
> 
> the headers in vdso.c is sorted now. However, the headers in mmu.c,
> dma-mapping.c, init.c aren't, for I dunno whether it's acceptable
> to do so. Or we could add one separate patch to make them sorted before
> applying __ro_after_init

Ah. Given that's a little messy, it's probably not worthwhile sorting them.
Further, feel free to not bother sorting the vdso.c includes.

Thanks,
Mark.
