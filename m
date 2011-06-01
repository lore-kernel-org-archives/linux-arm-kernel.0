From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 1 Jun 2011 21:17:51 +0800
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601093436.GF3660@n2100.arm.linux.org.uk>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
Message-ID: <20110601211751.69b85eeb@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 1 Jun 2011 10:34:36 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jun 01, 2011 at 03:42:59PM +0800, Ming Lei wrote:
> > @@ -435,6 +435,10 @@ __irq_usr:
> >  	usr_entry
> >  	kuser_cmpxchg_check
> >  
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> 
> I think this wants to be CONFIG_IRQSOFF_TRACER.

IMO, this should be CONFIG_TRACE_IRQFLAGS because we
want to trace interrupt disable and enable here, but
enabling CONFIG_IRQSOFF_TRACER means interrupt-off
latency tracer will be switched on, see kernel/trace/Kconfig.

--
Ming Lei
