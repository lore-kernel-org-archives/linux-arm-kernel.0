From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 1 Jun 2011 22:28:29 +0800
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601132233.GG3660@n2100.arm.linux.org.uk>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
	<20110601132233.GG3660@n2100.arm.linux.org.uk>
Message-ID: <20110601222829.6eaad0e6@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wed, 1 Jun 2011 14:22:33 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> From: Russell King - ARM Linux <linux@arm.linux.org.uk>

> If CONFIG_IRQSOFF_TRACER is not set, we don't bother telling the
> tracer that we've turned IRQs on for userspace when we exit from the
> kernel, and we don't bother telling the tracer that we've turned IRQs
> off when entering from userspace back into the kernel.
> 
> So, making this depend on CONFIG_TRACE_IRQFLAGS looks wrong to me.

>From lib/Kconfig.debug:

	config PROVE_LOCKING
		bool "Lock debugging: prove locking correctness"
		......
		select TRACE_IRQFLAGS

you can find locking prove does need to enable TRACE_IRQFLAGS. Meantime,
we may not enable irq off tracer via below:
	
	Kernel hacking  --->
		Tracers  --->
			[ ]   Interrupts-off Latency Tracer	

so making this depend on CONFIG_TRACE_IRQFLAGS is reasonable.

thanks,
--
Ming Lei
