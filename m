From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 04 Jun 2013 11:34:49 -0700
Subject: [PATCH RFC 2/3] ARM: dts: omap4 clock data
In-Reply-To: <20130604145543.GK3331@atomide.com>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-3-git-send-email-mturquette@linaro.org>
 <20130604145543.GK3331@atomide.com>
Message-ID: <20130604183449.10233.48956@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Lindgren (2013-06-04 07:55:43)
> * Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> > This is a first pass at creating a unique node for each clock in the
> > OMAP4 power, reset and & clock manager (PRCM).  So far I have only
> > converted mux clocks & fixed-rate clocks, which coexist with the current
> > clock data in the kernel.  The rest needs to be done but better to
> > publish early and often to see what others think of this approach.
> 
> > +/* FIXME need to print the address directly */
> > +/*
> > +#include "../../mach-omap2/prm44xx.h"
> > +#include "../../mach-omap2/cm2_44xx.h"
> > +#include "../../mach-omap2/cm1_44xx.h"
> > +*/
> 
> I don't think you're using the above includes any longer
> in this file?
> 

Correct.  I actually spotted this before emailing the patches out at
midnight, but by then I didn't care to fix it.  The benefits of marking
a patch as "RFC" ;-)

I had a mind to use the new preprocessor capabilities of dtc for the
PRCM bit masks and shift values, but instead I ended up using the raw
hex values.  I've actually come to prefer using the raw hex values for
DT, which I think makes more sense for a description of the hardware
which is not tied to any Linux implementation.

Regards,
Mike

> Regards,
> 
> Tony
