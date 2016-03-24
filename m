From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Mar 2016 17:11:44 +0000
Subject: [PATCH v3 03/18] irqchip: versatile-fpga: add new compatible for
 OX810SE SoC
In-Reply-To: <1458838215-23314-4-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <56F41FD0.2040504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/16 16:50, Neil Armstrong wrote:
> Under the OX810SE, this exact same interface is used as "Reference Peripheral
> Specification" Interrupt Controller, so add a new compatible string in order
> to support the PLX Technology OX810SE SoC interrupt controller.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
> index 598ab3f..37dd464 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -227,4 +227,5 @@ int __init fpga_irq_of_init(struct device_node *node,
>  }
>  IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
>  IRQCHIP_DECLARE(arm_fpga_sic, "arm,versatile-sic", fpga_irq_of_init);
> +IRQCHIP_DECLARE(ox810se_rps, "oxsemi,ox810se-rps-irq", fpga_irq_of_init);
>  #endif
> 

For patches 3 and 4:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
