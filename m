From: robherring2@gmail.com (Rob Herring)
Date: Wed, 10 Aug 2011 09:37:26 -0500
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <20110810141048.GK10121@e102144-lin.cambridge.arm.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<4E428EB0.1080204@gmail.com>
	<20110810141048.GK10121@e102144-lin.cambridge.arm.com>
Message-ID: <4E4297A6.6050101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 09:10 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Wed, Aug 10, 2011 at 02:59:12PM +0100, Rob Herring wrote:
>> I think you should allow for either the single irq or individual irqs.
>> You can specify that the event counter interrupt must be first, then the
>> pmu driver could work either way ignoring the rest. The driver probably
>> needs to mark the handler as shared if there is only the combined
>> interrupt unless you expect all interrupts to be handled by 1 driver.
> 
> I much prefer having seperate, individual IRQs with no requirement on
> ordering.
> 
> Now, the L2 binding also doesn't fit too well for the L2CC on Cortex-A15,
> which is an inner cache like the one on Cortex-A8. Because of this, it
> doesn't have a base address but it *does* have an IRQ which is how external
> aborts are raised.

This is not a general L2 binding, but an L2x0/PL310 binding. A8/A15 L2
is a completely different binding and driver though. You would do
something like the current cpu pmu binding that is just interrupts.

Rob
