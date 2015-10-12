From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 12 Oct 2015 13:52:02 -0400
Subject: [PATCH 09/10] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <20151010001915.GY26883@codeaurora.org>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-10-git-send-email-jonmason@broadcom.com>
 <20151010001915.GY26883@codeaurora.org>
Message-ID: <20151012175202.GE20867@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 05:19:15PM -0700, Stephen Boyd wrote:
> On 10/02, Jon Mason wrote:
> > diff --git a/drivers/clk/bcm/clk-ns2.c b/drivers/clk/bcm/clk-ns2.c
> > new file mode 100644
> > index 0000000..1d08281
> > --- /dev/null
> > +++ b/drivers/clk/bcm/clk-ns2.c
> > @@ -0,0 +1,290 @@
> > +/*
> > + * Copyright (C) 2015 Broadcom Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/err.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/clkdev.h>
> 
> clkdev looks unused here too?
> 
> > +#include <linux/of_address.h>
> > +#include <linux/delay.h>
> 
> And this one?

Yes, already caught this when you mentioned the other file :)

> 
> > +
> > +#include <dt-bindings/clock/bcm-ns2.h>
> > +#include "clk-iproc.h"
> > +
> > +#define reg_val(o, s, w) { .offset = o, .shift = s, .width = w, }
> 
> I guess we missed this one already, but this isn't a macro
> resembling a function. Kernel style is to capitalize this sort of
> macro.

I agree, but I was following prior example in
drivers/clk/bcm/clk-cygnus.c.  I can make the changes here and do a
patch for that file making the necessary changes as well.  Just let me
know your preference.

Thanks,
Jon

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
