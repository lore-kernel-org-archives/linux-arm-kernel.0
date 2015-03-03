From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 03 Mar 2015 17:56:47 +0200
Subject: [PATCH 00/10] initial clkdev cleanups
In-Reply-To: <54F4DB34.9000507@codeaurora.org>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <54F4DB34.9000507@codeaurora.org>
Message-ID: <1425398207.14897.152.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-02 at 13:50 -0800, Stephen Boyd wrote:
> On 03/02/15 09:05, Russell King - ARM Linux wrote:
> > Here's some initial clkdev cleanups.  These are targetted for the next
> > merge window, and while the initial patches can be merged independently,
> > I'd prefer to keep the series together as further work on solving the
> > problems which unique struct clk's has introduced is needed.


> > I'm also killing a chunk of seemingly unused code in the omap3isp driver.
> >
> > Lastly, I'm introducing a clkdev_create() helper, which combines the
> > clkdev_alloc() + clkdev_add() pattern which keeps cropping up.
> >
> 
> We already have a solution to that problem with clk_register_clkdev().
> Andy has done some work to make clk_register_clkdev() return a struct
> clk_lookup pointer[1]. Maybe we can do that instead of introducing a new
> clkdev_create() function. There is some benefit to having a new function
> though so that we can avoid a flag day, although it looks like the flag
> day is small in this case so it might not actually matter.

> [1] https://www.marc.info/?l=linux-kernel&m=142469226512289

Agree with Stephen, why should we have the second function doing the
same? Just name changing?

I think you may just incorporate that patch into your series.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
