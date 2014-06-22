From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Sun, 22 Jun 2014 22:56:54 +0200
Subject: [PATCH v3 3/7] irqchip: atmel-aic: add new atmel AIC driver
In-Reply-To: <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53A74316.5080509@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/06/2014 17:01, Boris BREZILLON wrote:
> Add new atmel AIC (Advanced Interrupt Controller) driver based on the
> generic chip infrastructure.
>
> This driver is only compatible with dt enabled board and replaces the old
> implementation found in arch/arm/mach-at91/irq.c.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig         |   7 +
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-atmel-aic.c | 700 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 708 insertions(+)
>  create mode 100644 drivers/irqchip/irq-atmel-aic.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bbb746e..6a7ad81 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -30,6 +30,13 @@ config ARM_VIC_NR
>  	  The maximum number of VICs available in the system, for
>  	  power management.
>  

[...]

> +
> +static int at91_aic_common_irq_domain_xlate(struct irq_domain *d,

This function should be named aic_common_irq_domain_xslate to be
consistent with other function names.
I'll fix that for the next version.


Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
