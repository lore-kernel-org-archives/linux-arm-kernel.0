From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 23 Feb 2018 09:42:38 +0100 (CET)
Subject: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
Message-ID: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Radoslaw,

On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:

> - discards setting handle_simple_irq handler for hierarchy interrupts
> - removes acking in chained irq handler as this is done by
> irq_chip itself inside handle_edge_irq
> - removes unneeded irq_domain_ops.xlate callback

if that's all functionally correct, then this is a nice cleanup. Though
from the above changelog its hard to tell because it merily tells WHAT the
patch does, but not WHY. The WHY is the important information for a
reviewer who is not familiar with the particular piece of code/hardware.

Can you please amend the changelog with proper explanations why a
particular piece of code is not needed or has to be changed to something
else?

Thanks,

	tglx
