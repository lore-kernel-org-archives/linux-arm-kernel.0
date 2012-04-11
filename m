From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Apr 2012 11:24:37 +0100
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <4F854992.9080601@freescale.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
 <4F840BDC.5060307@freescale.com> <4F854992.9080601@freescale.com>
Message-ID: <20120411102437.GE16643@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:06:26AM +0100, Huang Shijie wrote:
> Ok. Can you please:
> 
> (a) Make your test case available somewhere?
> 
> 
> I wish i could find a more common test case to reproduce this bug. But, i can't.
> The only test case now is to run the gplay on our IMX6Q platform.

Ok, that makes it tricky since I don't have gplay or an IMX6Q platform.

> (b) Try a more recent mainline kernel (3.3)?
> 
> 
> yes, I will try to test the linaro kernel.

Can you not try vanilla mainline instead? Either way, let me know how you
get on.

> The info of the libc:
>      GNU libc version: 2.13
>      GNU libc release: stable

That looks new enough for swp not to be an issue.

If you still have this problem with a newer kernel, we can try using the
fallback SMP futex implementation and see if that works.

Will
