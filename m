From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 8 Oct 2013 14:28:31 -0400 (EDT)
Subject: [PATCH 1/2] ARM: mcpm: fix big endian issue in mcpm startup code
In-Reply-To: <20131008175553.GB3866@localhost.localdomain>
References: <20131008175553.GB3866@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310081427350.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Oct 2013, Dave Martin wrote:

> On Mon, Oct 07, 2013 at 09:37:19PM -0700, Victor Kamensky wrote:
> > In big endian mode mcpm_entry_point is first function
> > that called on secondaries CPU. First it should switch
> > CPU into big endian code.
> > 
> > Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> 
> Providing Nico's also OK with it, I don't see a problem with this.
> 
> Minor cosmetic nit: please line up the ) after be with the others.
> Not the end of the world, though.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

No problem here.

Acked-by: Nicolas Pitre <nico@linaro.org>


> 
> Cheers
> ---Dave
> 
> > ---
> >  arch/arm/common/mcpm_head.S | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
> > index 39c96df..4f88f5e 100644
> > --- a/arch/arm/common/mcpm_head.S
> > +++ b/arch/arm/common/mcpm_head.S
> > @@ -15,6 +15,7 @@
> >  
> >  #include <linux/linkage.h>
> >  #include <asm/mcpm.h>
> > +#include <asm/assembler.h>
> >  
> >  #include "vlock.h"
> >  
> > @@ -47,6 +48,7 @@
> >  
> >  ENTRY(mcpm_entry_point)
> >  
> > + ARM_BE8(setend        be)
> >   THUMB(	adr	r12, BSYM(1f)	)
> >   THUMB(	bx	r12		)
> >   THUMB(	.thumb			)
> > -- 
> > 1.8.1.4
> > 
> > 
> > _______________________________________________
> > linaro-kernel mailing list
> > linaro-kernel at lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-kernel
> 
