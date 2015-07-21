From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Jul 2015 11:34:12 +0200 (CEST)
Subject: [PATCH 0/3] Shared NMI backtracing support for ARM/x86
In-Reply-To: <20150715203911.GF7557@n2100.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1507211132480.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015, Russell King - ARM Linux wrote:
> Back in September, I stumbled across a single CPU IRQs-off lockup of an
> ARM SMP system, and decided to hack something together based on a much
> older hacky implementation used with StrongARM CPUs from early 2000s.
> 
> This resulted in a copy of the x86 NMI backtrace code into ARM as it was
> back then, and feedback indicated that it wasn't a good time to push
> such an effort forward, as printk() in NMI context is dodgy.
> 
> Over time, the x86 code has had this problem addressed, and last week
> I updated the patch which I've been carrying in my tree to move the
> shared code out of arch/x86 into lib/ rather than duplicating it, and
> switch the ARM implementation to use it.
> 
> Discussing this with Thomas Gliexner, he agreed to give it a test over
> last weekend, and he has reported to me this evening "no explosion so
> far".  Since then, I've made a change to add the NOKPROBE_SYMBOL() to
> the generic handler as per the x86 original code.
> 
> I'm aware that there are other competing implementations out there -
> Daniel has one based on my patch from September time, but I don't think
> that goes far enough with code sharing.  I'm also partially aware of
> an implementation from Petr too.

I think we should just move ahead and apply this lot. Any improvements
can be done on top of this.

Russell, please take it through your tree.

Thanks,

	tglx
