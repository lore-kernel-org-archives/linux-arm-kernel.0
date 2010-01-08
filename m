From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 8 Jan 2010 12:20:14 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
Message-ID: <201001081220.14485.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> > +config HAVE_COMMON_STRUCT_CLK
> > +	bool
> > +	default n
> 
> default n is not needed

OK, can remove this.

> Probably should have here, and in all the other functions, something like:
> 
> 	if (!clk)
> 		return -EINVAL;

Is it at all valid to call the clock API functions with a NULL clock?

> Also, is any locking needed?

That's up to the implementer. For example, fixed rate clocks do not require 
locking.

> For clocks that are not configurable it might be a good idea to add:
> 
> 	unsigned long	rate;
> 
> to struct clk and then:
> 
> 	return clk->rate;
> 
> for the non-get_rate() condition.

Check out the clk_fixed patch (2/7), this implements fixed-rate clocks. I'm 
relucant to add anything to struct clock that isn't part of the kernel-wide 
API.

Cheers,


Jeremy
