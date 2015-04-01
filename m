From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Apr 2015 14:14:44 +0100
Subject: Reading twd_base at run-time
In-Reply-To: <551BEC33.1090702@free.fr>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr> <551BE476.2060102@arm.com>
 <551BEC33.1090702@free.fr>
Message-ID: <551BEF44.8020808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/15 14:01, Mason wrote:
> On 01/04/2015 14:28, Marc Zyngier wrote:
> 
>> It is worth mentioning that PERIPH_BASE is *not* an architected
>> register, so an implementation is perfectly allowed not to implement it.
>> Even on Cortex A9, a UP implementation will report PERIPH_BASE as zero.
>> It is still likely to have a TWD though.
> 
> It is interesting that you would mention TWD and UP implementations,
> because "config HAVE_ARM_TWD" depends on SMP, as I mentioned in a
> separate thread ("Dropping "depends on SMP" for HAVE_ARM_TWD").
> 
> Would it make sense to drop the dependency?
> 
> I have a single-core Cortex A9 MPcore system where I want to use
> the local timers. If it's too much trouble changing the build
> options, I suppose I can just run an SMP kernel?

There used to be a time where the TWD was completely tied to the SMP
code, but I think we now deal with per-cpu timers in a way similar to
the global timers (more or less...).

Worth trying, and see what breaks. On the other hand, SMP on UP should
give you the same result.

	M.
-- 
Jazz is not dead. It just smells funny...
