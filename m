From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2011 18:55:00 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110527120629.GA32617@elte.hu>
References: <BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
Message-ID: <20110527175500.GQ24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 02:06:29PM +0200, Ingo Molnar wrote:
> I'd suggest doing this once modern ARM chips get so widespread that 
> you can realistically induce a ~700 usecs irqs-off delays on old, 
> virtual-cache ARM chips. Old chips would likely use old kernels 
> anyway, right?

Not necessarily.  I have rather a lot of legacy hardware (it outweighs
the more modern stuff) and that legacy hardware is _loads_ more useful
than the modern stuff in that it can actually do stuff like run a network
(such as running kerberos servers, httpd, mtas, etc).  Modern ARM
machines typically don't have ways to attach mass storage to them which
make them hellishly limited for such applications.

I'm planning to continue using my old machines, and continue to upgrade
their kernels, especially in order to keep up to date with security
issues.
