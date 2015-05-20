From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 22:02:12 +0200 (CEST)
Subject: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <alpine.DEB.2.11.1505202157190.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 May 2015, Hanjun Guo wrote:
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 65d6b93..855ead9 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
>  	if (acpi_disabled)
>  		return;
>  
> +	if (acpi_gic_version_init())
> +		return;

This looks just wrong. acpi_irqchip_init() is a generic ACPI function
and now you stick a GIC specific callback into it?

What calls acpi_irqchip_init?

Thanks,

	tglx
