From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 13 Jun 2018 12:07:10 +0100
Subject: [PATCH v4 26/26] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
In-Reply-To: <1527241772-48007-27-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-27-git-send-email-julien.thierry@arm.com>
Message-ID: <5f1ff644-6416-3bd2-c817-5a86e16e251e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 10:49, Julien Thierry wrote:
> Provide a way to set a GICv3 interrupt as pseudo-NMI. The interrupt
> must not be enabled when setting/clearing the NMI status of the interrupt.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/interrupt.h    |  1 +
>   2 files changed, 55 insertions(+)
> 

[...]

> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 5426627..02c794f 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -419,6 +419,7 @@ enum irqchip_irq_state {
>   	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
>   	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
>   	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
> +	IRQCHIP_STATE_NMI,		/* Is IRQ an NMI? */
>   };

After discussing with Thomas, NMI setting should not be exposed/managed 
through the generic irq interface.

-- 
Julien Thierry
