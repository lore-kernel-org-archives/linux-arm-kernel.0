From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Aug 2017 08:56:03 +0100
Subject: [PATCH] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170819171812.21902-1-laurentiu.tudor@nxp.com>
References: <20170819171812.21902-1-laurentiu.tudor@nxp.com>
Message-ID: <6b15ec08-5f8b-37d5-5b90-fe2fbf2c60a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/17 18:18, laurentiu.tudor at nxp.com wrote:
> From: Stuart Yoder <stuart.yoder@nxp.com>
> 
> Move the source files out of staging into their final locations:
>   -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>   -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>   -README.txt, providing and overview of DPAA goes to
>    Documentation/dpaa2/overview.txt
> 
> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
> Update dpaa2_eth and dpio staging drivers.
> 
> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

[...]

> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e88d856..4839165 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> +obj-$(CONFIG_FSL_MC_BUS)		+= irq-gic-v3-its-fsl-mc-msi.o

Please keep the ITS bus glue next to the rest of the ITS code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
