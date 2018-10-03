From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Oct 2018 10:26:00 +0100
Subject: [PATCH v5 19/27] irqchip/gic-v3: Remove acknowledge loop
In-Reply-To: <1535471497-38854-20-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-20-git-send-email-julien.thierry@arm.com>
Message-ID: <ee78b536-6a87-52c7-16c4-292f7ecbe61a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/18 16:51, Julien Thierry wrote:
> Multiple interrupts pending for a CPU is actually rare. Doing an
> acknowledge loop does not give much better performance or even can
> deteriorate them.
> 
> Do not loop when an interrupt has been acknowledged, just return
> from interrupt and wait for another one to be raised.
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3.c | 65 +++++++++++++++++++++-----------------------
>   1 file changed, 31 insertions(+), 34 deletions(-)

It would probably be valuable to do the same thing for GICv1/v2, where 
the MMIO access can be even more costly.

In the meantime, I've queued this for 4.20.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
