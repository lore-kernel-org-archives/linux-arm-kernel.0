From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2011 22:10:18 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110830205802.GT2061@opensource.wolfsonmicro.com>
References: <20110823221314.GL3895@n2100.arm.linux.org.uk>
	<CAOS58YNtQEuke=Ko9J2oNGMECjabzxj=Nrg1o64X1JC3YRmJuw@mail.gmail.com>
	<20110825121416.GB8883@n2100.arm.linux.org.uk>
	<20110825121710.GK3286@htj.dyndns.org>
	<20110825122543.GC8883@n2100.arm.linux.org.uk>
	<20110825123542.GM3286@htj.dyndns.org>
	<20110825130414.GE8883@n2100.arm.linux.org.uk>
	<20110825130907.GO3286@htj.dyndns.org>
	<20110825145558.GF8883@n2100.arm.linux.org.uk>
	<20110830205802.GT2061@opensource.wolfsonmicro.com>
Message-ID: <20110830211018.GB17887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 09:58:03PM +0100, Mark Brown wrote:
> On Thu, Aug 25, 2011 at 03:55:58PM +0100, Russell King - ARM Linux wrote:
> 
> > Here's the patch.  As the kernel I've run this against doesn't have the
> > change to try_to_freeze(), I added a might_sleep() in do_signal() during
> > my testing to verify that it fixes Mark's problem (which it does.)
> 
> > Mark, can you test this to make sure it fixes your problem please?
> 
> Yes, it resolves the problem for me - thanks!
> 
> Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Sorry about the delay, was away for the bank holiday weekend.

That's good, thanks.

Just waiting for Ulrich Weigand to verify that his gdb test-case doesn't
break with this patch.
