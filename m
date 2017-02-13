From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:38:43 +0100 (CET)
Subject: [RFC PATCH 19/33] irqchip/gic-v3-its: Add VLPI configuration
 handling
In-Reply-To: <1484648454-21216-20-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131138080.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:

> When a VLPI is reconfigured (enabled, disabled, change in priority),
> the full configuration byte must be written, and the caches invalidated.
> 
> Also, when using the irq_mask/irq_unmask methods, it is necessary
> to disable the doorbell for that particular interrupt (by mapping it
> to 1023) on top of clearing the Enable bit.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Aside of the switch/case part:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
