From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Aug 2017 19:40:12 -0500
Subject: [PATCH v2] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170823004012.nxpslh37we7btqkg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 07:01:03PM +0900, Masahiro Yamada wrote:
> UniPhier SoCs contain AIDET (ARM Interrupt Detector).  This is intended
> to provide additional features that are not covered by GIC.  The main
> purpose is to provide logic inverter to support low level and falling
> edge trigger type for interrupt lines from on-board devices.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
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

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   1 +
>  drivers/irqchip/Kconfig                            |   8 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-uniphier-aidet.c               | 246 +++++++++++++++++++++
>  5 files changed, 288 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>  create mode 100644 drivers/irqchip/irq-uniphier-aidet.c
