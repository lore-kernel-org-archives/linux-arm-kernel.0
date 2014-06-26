From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 26 Jun 2014 22:20:24 +0200
Subject: [PATCH v3 3/7] irqchip: atmel-aic: add new atmel AIC driver
In-Reply-To: <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53AC8088.6020905@free-electrons.com>
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
> +config ATMEL_AIC_IRQ
> +	bool
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN
> +	select MULTI_IRQ_HANDLER
> +	select SPARSE_IRQ
> +

I just though a bit about it and it might be better to split AIC and
AIC5 support in 2 different drivers, because the AIC is only available
on at91sam9/at91rm9200 SoCs and AIC5 only available on sama5 SoCs, and
AFAICT there is no combination of both controller in a singler SoC.

Jason, Thomas, let me know if you think this worth the trouble, and if
so, should I keep a common implementation (in irq-atmel-aic-common.c/.h)
for the shared functions/structures.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
