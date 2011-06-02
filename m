From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 2 Jun 2011 09:32:51 +0800
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601160144.GN3660@n2100.arm.linux.org.uk>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
	<20110601132233.GG3660@n2100.arm.linux.org.uk>
	<20110601222829.6eaad0e6@tom-ThinkPad-T410>
	<20110601144630.GL3660@n2100.arm.linux.org.uk>
	<20110601235221.5aab9182@tom-ThinkPad-T410>
	<20110601160144.GN3660@n2100.arm.linux.org.uk>
Message-ID: <20110602093251.0001a4cd@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Thanks for your detailed explain.

On Wed, 1 Jun 2011 17:01:44 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> So, the way things are setup at the moment on ARM, we "optimize" the
> overhead of telling lockdep that IRQs are enabled while userspace is
> running away _provided_ we are not doing IRQs-off latency tracing.
> IOW, when CONFIG_IRQSOFF_TRACER is not set, we optimize away the
> trace_hardirq_on call when entering userspace, and the
> trace_hardirq_off call when leaving userspace.

Sorry, I did not notice this "optimization" before, and will
change the dependency and update the patch.

BTW, the patch also fixes for irq off tracer.


thanks,
--
Ming Lei
