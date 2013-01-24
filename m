From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Jan 2013 11:02:09 +0530
Subject: [PATCH 2/4] arm: Move chained_irq_(enter|exit) to a generic file
In-Reply-To: <1358963974-5496-3-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <5100C759.4070503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 January 2013 11:29 PM, Catalin Marinas wrote:
> These functions have been introduced by commit 10a8c383 (irq: introduce
> entry and exit functions for chained handlers) in asm/mach/irq.h. This
> patch moves them to linux/irqchip/chained_irq.h so that generic irqchip
> drivers do not rely on architecture specific header files.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---

[..]

> diff --git a/include/linux/irqchip/chained_irq.h b/include/linux/irqchip/chained_irq.h
> new file mode 100644
> index 0000000..adf4c30
> --- /dev/null
> +++ b/include/linux/irqchip/chained_irq.h
> @@ -0,0 +1,52 @@
> +/*
> + * Chained IRQ handlers support.
> + *
> + * Copyright (C) 2011 ARM Ltd.
2013 now ;)
