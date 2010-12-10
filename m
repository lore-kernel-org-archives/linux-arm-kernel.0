From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 10 Dec 2010 19:43:10 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1292004654.13513.38.camel@laptop>
References: <1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins> <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins> <1291988866.6803.171.camel@twins>
	<20101210175645.GB28263@n2100.arm.linux.org.uk>
	<1292004654.13513.38.camel@laptop>
Message-ID: <1292006590.13513.40.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-10 at 19:10 +0100, Peter Zijlstra wrote:
> There are lots of places in the scheduler that rely on u64 wrap, for now
> the easiest thing for ARM would be to select HAVE_UNSTABLE_SCHED_CLOCK
> for those platforms that implement a short sched_clock().
> 
> While that isn't ideal it is something that makes it work, we can work
> on something more suitable for future kernels. 

Either that, or the thing you proposed a while back in this thread.

Since ARM doesn't have NMIs something like that should work just fine.
