From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 15 Nov 2017 13:38:39 +0200
Subject: Fwd: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <20171115062837.GA22802@codeaurora.org>
References: <1510096056-13765-3-git-send-email-timur@codeaurora.org>
 <b2b5374b-17a6-e068-ef8b-edc90d34c352@codeaurora.org>
 <20171115062837.GA22802@codeaurora.org>
Message-ID: <1510745919.25007.234.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-15 at 11:58 +0530, Varadarajan Narayanan wrote:

> > +	if (gpiochip->irq_need_valid_mask) {
> > +		gpiochip->irq_valid_mask =
> > +			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
> > +				sizeof(long), GFP_KERNEL);
> 
> Since 'irq_valid_mask' is getting filled below wouldn't a kmalloc
> suffice?

I suppose you meant kmalloc_array.
Anyway, it's a separate change if you wish, because Timur didn't change
the original approach here.

> > +		if (!gpiochip->irq_valid_mask)
> > +			return -ENOMEM;
> > 


> > +		/* Assume by default all GPIOs are valid */
> > +		bitmap_fill(gpiochip->irq_valid_mask, gpiochip-
> > >ngpio);
> > +	}
> > 


> > +	if (gpiochip->line_need_valid_mask) {
> > +		gpiochip->line_valid_mask =
> > +			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
> > +				sizeof(long), GFP_KERNEL);
> 
> Since 'line_valid_mask' is getting filled below wouldn't a kmalloc
> suffice?

This one just mimics previous, so, see above.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
