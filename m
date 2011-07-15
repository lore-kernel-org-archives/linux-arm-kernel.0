From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 15 Jul 2011 08:15:59 -0500
Subject: ARM cortex A9 feature
In-Reply-To: <CABi1daFp=mKw0kq=Vm_T9RKeHfnXsA-kssdRm56AhkaJ4FjCxA@mail.gmail.com>
References: <CAJ8eaTzLmSTSMOY-0Xg0tE-DEbZ6RNA+uh70Dn3K5CbrjQsEiA@mail.gmail.com>
	<CABi1daHh7cgyhJ4c3zo+jSUY4uzbFtihtgw0Q2Mcrndno_gcTA@mail.gmail.com>
	<CAJ8eaTyqOBq2mbfvuTun=bVvhFSrMqJ5uVyd+cozF5PtVeSVaw@mail.gmail.com>
	<CABi1daFp=mKw0kq=Vm_T9RKeHfnXsA-kssdRm56AhkaJ4FjCxA@mail.gmail.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203F21C4D14@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dave Hylands
> Sent: Friday, July 15, 2011 1:03 AM
> To: naveen yadav

> > what is usecase for this . This is my question .
> 
> Since I've never used one, I'm not sure. Maybe somebody else knows.

The exclusive L2 feature is not the default option.

If you choose a small L2 size when configuring your CortexA hardware it might be useful.

A friend who did early x86/amd design indicated this feature was used when L1 & L2 caches were near the same size back in 90's. Going exclusive can have the effect of near doubling cache size.  As L2 got much bigger most folks stopped using it...presumably benchmarks fell off and it wasn't worth validation effort of carrying an option not commonly used.

The CortexA8 r1px rev's was exclusive only (like in omap3430).  Later A8 rev's (like omap3630) and A9 (omap4430) added and defaulted to non-exclusive.  Early L2's were 64K,128K,256K so adding 32K to a 64K probably did make sense.  Today in A9's (omap4460) and A15's (omap5430) with 1M and 2M L2 sizes +32K is not so impacting.

The A8's L2 was pretty quick (like 8 cycles) to registers on an A9 with external L2 you only can configure like 22 cycles.  Mixing with speed differences might create some other issues.

If you care about correlating benchmark results back to hardware actuals for things like lmbench, you find the exclusive configuration muddies several test results.

Regards,
Richard W.
