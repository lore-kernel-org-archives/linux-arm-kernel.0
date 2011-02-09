From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Feb 2011 09:51:27 -0000
Subject: [RFC PATCH] ARM: pmu: add OF match support
In-Reply-To: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
References: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
Message-ID: <001b01cbc83e$ec0a59e0$c41f0da0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> Add OF match table to enable OF style driver binding. The dts entry is like
> this:
> 
> pmu {
> 	compatible = "arm,pmu";
> 	interrupts = <100 101>;
> };
> 
> The use of pdev->id as an index breaks with OF device binding. Change to use
> a counter instead. If more than 1 pmu device is ever really supported, a
> better solution to match users with particular pmu is probably needed.

We will want to support multiple PMU devices in the near future but
this is currently blocked on userspace issues. One such device would
be the event counters on the PL310, which could be used to complement
the CPU PMU on the Cortex-A9.

I don't like the idea of a counter as it forces platforms to register
their devices in a specific order. Is it possible to separate different
types of PMU in the device tree and then have pmu.c work out what to do
with them?

Will
