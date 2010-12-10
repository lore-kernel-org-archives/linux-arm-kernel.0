From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Dec 2010 16:50:21 +0000
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291988866.6803.171.camel@twins>
References: <1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins> <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins> <1291988866.6803.171.camel@twins>
Message-ID: <20101210165021.GA28263@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 02:47:46PM +0100, Peter Zijlstra wrote:
> 
> Full patch..
> 
> ---
> Subject: sched: Fix the irqtime code to deal with u64 wraps
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Thu Dec 09 14:15:34 CET 2010
> 
> ARM systems have a 32bit sched_clock() [ which needs to be fixed ],
> but this exposed a bug in the irq_time code as well, it doesn't deal
> with wraps at all.
> 
> Fix the irq_time code to deal with u64 wraps by re-writing the code to
> only use delta increments, which avoids the whole issue.
> 
> Furthermore, solve the problem of 32bit arches reading partial updates
> of the u64 time values.
> 
> Cc: Venkatesh Pallipadi <venki@google.com>
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>

I think credit should go to Mikael Pettersson, who identified the
interactivity regression and problematical commit.  I only pointed
out the dubious nature of the code.
