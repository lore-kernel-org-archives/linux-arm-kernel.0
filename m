From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 May 2018 17:41:09 +0100
Subject: [PATCH v3 0/5]
In-Reply-To: <alpine.DEB.2.21.1805181222380.11339@macbook-air>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1805181222380.11339@macbook-air>
Message-ID: <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[/me beats himself for not writing a subject line...]

On 18/05/18 17:29, Vince Weaver wrote:
> On Fri, 18 May 2018, Marc Zyngier wrote:
> 
>> There is also the case of people natively running 32bit kernels on
>> 64bit HW and trying to upstream unspeakable hacks, hoping that the
>> stars will align and that they'll win the lottery (see [1]).
> 
> I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
> (4.17-rc5-git) kernel and they work.
> 
> [    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
> 
> I only needed to add this to the devicetree
> 
> 	arm-pmu {
> 		compatible = "arm,cortex-a53-pmu";
> 		interrupt-parent = <&local_intc>;
> 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> 	};

That's definitely the sensible thing to have on such hardware. Why isn't
it in the upstream DT already, irrespective of the state of the kernel
support?

> Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Thanks a lot for testing.

	M.
-- 
Jazz is not dead. It just smells funny...
