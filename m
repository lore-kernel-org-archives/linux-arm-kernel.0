From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 24 Feb 2015 01:26:05 +0100
Subject: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
In-Reply-To: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
References: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
Message-ID: <3607139.EdDhxoz0si@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 20, 2015 02:53:46 PM Mark Rutland wrote:
> The IRQF_NO_SUSPEND flag is intended to be used for interrupts required
> to be enabled during the suspend-resume cycle. This mostly consists of
> IPIs and timer interrupts, potentially including chained irqchip
> interrupts if these are necessary to handle timers or IPIs. If an
> interrupt does not fall into one of the aforementioned categories,
> requesting it with IRQF_NO_SUSPEND is likely incorrect.
> 
> Using IRQF_NO_SUSPEND does not guarantee that the interrupt can wake the
> system from a suspended state. For an interrupt to be able to trigger a
> wakeup, it may be necessary to program various components of the system.
> In these cases it is necessary to use {enable,disabled}_irq_wake.
> 
> Unfortunately, several drivers assume that IRQF_NO_SUSPEND ensures that
> an IRQ can wake up the system, and the documentation can be read
> ambiguously w.r.t. this property.
> 
> This patch updates the documentation regarding IRQF_NO_SUSPEND to make
> this caveat explicit, hopefully making future misuse rarer. Cleanup of
> existing misuse will occur as part of later patch series.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Applied to linux-pm.git/linux-next, thanks!

Peter, please let me know if you don't want this to go it.

Rafael
