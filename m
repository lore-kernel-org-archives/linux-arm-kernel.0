From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 8 Jan 2010 11:25:34 -0500
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001081426.09754.jk@ozlabs.org>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020896AE@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 07, 2010 8:26 PM, Jeremy Kerr wrote:
> Hi Hartley,
>
>> I'm relucant to add anything to struct clock that isn't part of the kernel-
>> wide API.
>
> This may have been a little cryptic, I'm sorry. The reason for not adding a 
> 'rate' member to the public clock API is that there would be now two methods 
> for getting the rate of a clock: calling clk->get_rate or accessing clk->rate 
> directly. The latter is not always guaranteed to work (perhaps there's a clock 
> out there that needs an explicit HW query to get the rate), so we don't want 
> generic drivers to be able to access this.

No, I understood what you meant.  But, thanks for clarifying.

I was just trying to figure out if it was worth trying to use this in
mach-ep93xx.  It looks like it would be pretty straight forward but
the implementation is going to use quite a bit more memory because to the
size of the common struct.

For now I think I will leave ep93xx as it is.

Thanks,
Hartley
