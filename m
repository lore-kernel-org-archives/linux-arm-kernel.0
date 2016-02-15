From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 15 Feb 2016 17:35:52 +0200
Subject: Common/typical fractional divider HW API
In-Reply-To: <56B76B26.4050306@free.fr>
References: <56B4B67D.2080707@free.fr>
 <1454684758.31169.77.camel@linux.intel.com> <56B4C775.50808@free.fr>
 <1454688729.31169.87.camel@linux.intel.com> <56B4CDEF.3080606@free.fr>
 <1454690599.31169.103.camel@linux.intel.com> <56B76B26.4050306@free.fr>
Message-ID: <1455550552.31169.135.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-02-07 at 17:04 +0100, Mason wrote:
> On 05/02/2016 17:43, Andy Shevchenko wrote:
> 
> > There are plenty of implementations of the divider.
> 
> I'd be happy to read an overview on the subject, if you have
> some links to share.

drivers/tty/serial/*

> 
> > You might consider to use one than inventing new one
> 
> I find it hard to believe that the interface I'm discussing
> has not been used (several times) in the past. (It's merely
> a trivial floating point scheme.)
> 
> As a matter of fact, the integer divider driver supports
> "I" and "2^I", so extending 2^I to "2^I * (1 + F/256)"
> is an obvious step.

Just to be simple:
Why do you have to modify existing clk-fractional-divider.c module?

May I suggest to reconsider your design to be fit in the existing CLK
divider implementations? Also, some of the hardware IPs have inside
divider registers, like mentioned above UARTs. I already suggested to
look at them to see how hardware is done.

Again, (actually I bored to repeat) I didn't see (yet!) any HW divider
which has integer part as 2^I. I don't get why you stuck with that
formula and why 1/256? Who prevents to have 1/32768 in HW (like we have
in LPSS of Intel SoCs)?

Here I'm giving up this discussion. Perhaps more experienced people
could correct me.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
