From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 21 Mar 2018 22:31:14 +0200
Subject: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
In-Reply-To: <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-3-swboyd@chromium.org>
 <1521655150.23017.79.camel@linux.intel.com>
 <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
Message-ID: <1521664274.23017.92.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-21 at 12:59 -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2018-03-21 10:59:10)
> > On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > > 

> > 
> > > +     gpiochip->valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> > > > ngpio),
> > > 
> > > +                                    sizeof(long), GFP_KERNEL);
> > 
> > Just noticed that kcalloc is superfluous here.
> > kmalloc_array() would be enough.
> > 
> 
> Ok. I was copying the irqchip style. Should I fold them together into
> a
> helper function and also update to kmalloc_array?

Not sure about first part, but definitely makes sense the second one (as
a separate patch perhaps).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
