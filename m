From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 15:28:08 +0100
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <201108101624.27881.arnd@arndb.de>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<4E428EB0.1080204@gmail.com>
	<20110810141048.GK10121@e102144-lin.cambridge.arm.com>
	<201108101624.27881.arnd@arndb.de>
Message-ID: <20110810142808.GL10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 03:24:27PM +0100, Arnd Bergmann wrote:
> On Wednesday 10 August 2011, Will Deacon wrote:
> > On Wed, Aug 10, 2011 at 02:59:12PM +0100, Rob Herring wrote:
> > > I think you should allow for either the single irq or individual irqs.
> > > You can specify that the event counter interrupt must be first, then the
> > > pmu driver could work either way ignoring the rest. The driver probably
> > > needs to mark the handler as shared if there is only the combined
> > > interrupt unless you expect all interrupts to be handled by 1 driver.
> > 
> > I much prefer having seperate, individual IRQs with no requirement on
> > ordering.
> > 
> 
> What do you mean with 'no requirement on ordering'? If we have multiple
> interrupt sources, we definitely want to identify which one calls which
> handler, and the only information we have is the position in the array
> of interrupt numbers.

I was hoping that it was possible to have separate properties which describe
the interrupt. So you could have something like pmu-interrupt <75> and
abort-interrupt <76> rather than interrupts <75, 76>.

I've not played with DT bindings before though, so if it's usually done with
an ordered list then so be it!

Will
