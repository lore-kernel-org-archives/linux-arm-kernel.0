From: vincent.weaver@maine.edu (Vince Weaver)
Date: Fri, 18 May 2018 12:29:36 -0400 (EDT)
Subject: [PATCH v3 0/5]
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1805181222380.11339@macbook-air>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2018, Marc Zyngier wrote:

> There is also the case of people natively running 32bit kernels on
> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> stars will align and that they'll win the lottery (see [1]).

I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
(4.17-rc5-git) kernel and they work.

[    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available

I only needed to add this to the devicetree

	arm-pmu {
		compatible = "arm,cortex-a53-pmu";
		interrupt-parent = <&local_intc>;
		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
	};


Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Vince
