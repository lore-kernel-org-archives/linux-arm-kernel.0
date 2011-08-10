From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2011 16:24:27 +0200
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <20110810141048.GK10121@e102144-lin.cambridge.arm.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<4E428EB0.1080204@gmail.com>
	<20110810141048.GK10121@e102144-lin.cambridge.arm.com>
Message-ID: <201108101624.27881.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Will Deacon wrote:
> On Wed, Aug 10, 2011 at 02:59:12PM +0100, Rob Herring wrote:
> > I think you should allow for either the single irq or individual irqs.
> > You can specify that the event counter interrupt must be first, then the
> > pmu driver could work either way ignoring the rest. The driver probably
> > needs to mark the handler as shared if there is only the combined
> > interrupt unless you expect all interrupts to be handled by 1 driver.
> 
> I much prefer having seperate, individual IRQs with no requirement on
> ordering.
> 

What do you mean with 'no requirement on ordering'? If we have multiple
interrupt sources, we definitely want to identify which one calls which
handler, and the only information we have is the position in the array
of interrupt numbers.

	Arnd
