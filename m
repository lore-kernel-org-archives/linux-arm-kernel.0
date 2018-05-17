From: vincent.weaver@maine.edu (Vince Weaver)
Date: Thu, 17 May 2018 15:31:38 -0400 (EDT)
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171422450.8529@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
Message-ID: <alpine.DEB.2.21.1805171530080.8529@macbook-air>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018, Vince Weaver wrote:

> On Thu, 17 May 2018, Peter Zijlstra wrote:
> with cortex-a7 now, would it be possible to later drop that if proper 
> cortex-a53 support is added to the armv7 pmu driver?  Or would that lead 
> to all kinds of back-compatability mess?

For what it's worth, the pi-foundation kernel bcm2710 device tree file 
does:

		arm-pmu {
#ifdef RPI364
			compatible = "arm,armv8-pmuv3", "arm,cortex-a7-pmu";
#else
			compatible = "arm,cortex-a7-pmu";
#endif
			interrupt-parent = <&local_intc>;
			interrupts = <9>;
		};


Which is probably where I was getting the arm,armv8-pmuv3 from in my 
original patch.

Vince
