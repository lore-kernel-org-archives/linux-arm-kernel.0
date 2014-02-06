From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Feb 2014 22:14:40 +0100 (CET)
Subject: [PATCH] irq: Add new flag to ack level-triggered interrupts
 before unmasking
In-Reply-To: <1391721117-27446-1-git-send-email-carlo@caione.org>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
Message-ID: <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Feb 2014, Carlo Caione wrote:

> Several irqchip drivers require the level-triggered interrupt to be
> acked before unmasking to avoid that a second interrupt is immediately
> triggered. This small patch introduces a new irqchip flags that is used
> to ack the IRQ line before it is unmasked.

And why are you not doing this in the unmask function of the affected
chip in the first place?
 
Thanks,

	tglx
