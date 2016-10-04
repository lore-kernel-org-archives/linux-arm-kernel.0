From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Oct 2016 09:23:30 +0200 (CEST)
Subject: [PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
In-Reply-To: <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
References: <1475343976-20744-1-git-send-email-okaya@codeaurora.org>
 <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1610040919110.5278@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 1 Oct 2016, Sinan Kaya wrote:

> This reverts commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize
> function"). SCI penalty API was replaced by the runtime penalty calculation
> based on the value of acpi_gbl_FADT.sci_interrupt.

This does more than only reverting said commit ....
 
> acpi_gbl_FADT.sci_interrupt type does not get updated at the right time
> for some platforms and results in incorrect penalty assignment for PCI
> IRQs as irq_get_trigger_type returns the wrong type.

And the obvious question is: Why does irq_get_trigger_type() return the
wrong type?

What's the root cause of this problem? Your changelog does not tell
anything.

Thanks,

	tglx
