From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 18 May 2018 19:39:38 +0200 (CEST)
Subject: [PATCH v3 0/5]
In-Reply-To: <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1805181222380.11339@macbook-air>
 <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
Message-ID: <1113496355.72893.1526665178400@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Marc Zyngier <marc.zyngier@arm.com> hat am 18. Mai 2018 um 18:41 geschrieben:
> 
> 
> [/me beats himself for not writing a subject line...]
> 
> On 18/05/18 17:29, Vince Weaver wrote:
> > On Fri, 18 May 2018, Marc Zyngier wrote:
> > 
> >> There is also the case of people natively running 32bit kernels on
> >> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> >> stars will align and that they'll win the lottery (see [1]).
> > 
> > I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
> > (4.17-rc5-git) kernel and they work.
> > 
> > [    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
> > 
> > I only needed to add this to the devicetree
> > 
> > 	arm-pmu {
> > 		compatible = "arm,cortex-a53-pmu";
> > 		interrupt-parent = <&local_intc>;
> > 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> 
> That's definitely the sensible thing to have on such hardware. Why isn't
> it in the upstream DT already, irrespective of the state of the kernel
> support?

I remember that Vince point out the absence. He asked about how to implement it and i wasn't sure about it. At this time we hadn't IRQ polarity support. So we wanted to get this puzzle piece before. In march i put it on my TODO list, but then RPI 3 B+ support had higher prio to get into 4.18.

In general we have the problem that most of the users take the downstream kernel and don't know about the differences. Luckily more distributions switch to the upstream kernel, which increases the feedback.

> 
> > Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Thanks again
Stefan

> 
> Thanks a lot for testing.
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
