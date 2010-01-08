From: jk@ozlabs.org (Jeremy Kerr)
Date: Fri, 8 Jan 2010 14:26:09 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001081220.14485.jeremy.kerr@canonical.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
Message-ID: <201001081426.09754.jk@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> I'm relucant to add anything to struct clock that isn't part of the kernel-
> wide API.

This may have been a little cryptic, I'm sorry. The reason for not adding a 
'rate' member to the public clock API is that there would be now two methods 
for getting the rate of a clock: calling clk->get_rate or accessing clk->rate 
directly. The latter is not always guaranteed to work (perhaps there's a clock 
out there that needs an explicit HW query to get the rate), so we don't want 
generic drivers to be able to access this.

Cheers,


Jeremy
