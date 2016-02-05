From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 05 Feb 2016 18:12:09 +0200
Subject: Common/typical fractional divider HW API
In-Reply-To: <56B4C775.50808@free.fr>
References: <56B4B67D.2080707@free.fr>
 <1454684758.31169.77.camel@linux.intel.com> <56B4C775.50808@free.fr>
Message-ID: <1454688729.31169.87.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-02-05 at 17:01 +0100, Mason wrote:

> So, do you agree that
> 
> ? DIV = 2^I * (1 + F/256)
> 
> gives a more useful DIV distribution than
> 
> ? DIV = I + F/16

If you can change hardware why not to use any existing approach which
suits better to your device?

I don't remember any existing, though I didn't check much, divider
register which takes something like that.

> > Also it's possible to convert clock providers for, e.g., UARTs to
> > use
> > this kind of divider.
> 
> I'm not sure how to parse that. I'm using the divider driver
> for a CPU clock, to do D(V)FS in cpufreq.

If you are using custom stuff for custom hardware, I hope it's okay.
But if we are talking about generic solutions (like clk-fractional-
divider), I would suggest to consider existing users / hardware.

What I saw is mostly about

I [0 .. 2^n - 1]
F [0 .. 2^k - 1]
n + k < 32

And I + 1 / (2^k - F) as a formula.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
