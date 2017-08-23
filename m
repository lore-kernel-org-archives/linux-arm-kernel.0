From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Aug 2017 09:01:10 +0100
Subject: [PATCH v3] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <1503451907-21535-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503451907-21535-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <5dfc1478-c558-eb6d-6a82-a9ca23851bcd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/17 02:31, Masahiro Yamada wrote:
> UniPhier SoCs contain AIDET (ARM Interrupt Detector).  This is intended
> to provide additional features that are not covered by GIC.  The main
> purpose is to provide logic inverter to support low level and falling
> edge trigger types for interrupt lines from on-board devices.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v3:
>   - Use irq_domain_create_hierarchy() instead of legacy
>     irq_domain_add_hierarchy()
>   - Add .irq_set_affinity hook
>   - Pass proper trigger type to parent
> 
> Changes in v2:
>   - Use readl/write_relaxed instead of readl/writel
>   - Move val = 0 for code symmetry
>   - .alloc() hook only supports nr_irqs==1 case
>   - Move struct irq_chip to static data because this driver expects
>     only one device instance in the system
>   - Match the interrupt number to SPI of GIC to make DT binding clearer
>     (register offset starts from 0x4)
> 
>  .../socionext,uniphier-aidet.txt                   |  32 +++
>  MAINTAINERS                                        |   1 +
>  drivers/irqchip/Kconfig                            |   8 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-uniphier-aidet.c               | 261 +++++++++++++++++++++
>  5 files changed, 303 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>  create mode 100644 drivers/irqchip/irq-uniphier-aidet.c
Queued for 4.14.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
