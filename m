From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Jul 2017 23:15:49 +0200 (CEST)
Subject: [PATCH v2 01/52] genirq: Let irq_set_vcpu_affinity() iterate
 over hierarchy
In-Reply-To: <20170628150411.15846-2-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
 <20170628150411.15846-2-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1707042315370.2131@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 28 Jun 2017, Marc Zyngier wrote:

> When assigning an interrupt to a vcpu, it is not unlikely that
> the level of the hierarchy implementing irq_set_vcpu_affinity
> is not the top level (think a generic MSI domain on top of a
> virtualization aware interrupt controller).
> 
> In such a case, let's iterate over the hierarchy until we find
> an irqchip implementing it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
