From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 27 Jun 2012 15:30:20 +0800
Subject: Could resource_size can be used for IORESOURCE_IRQ in device tree?
Message-ID: <CAMj5BkhkybgAAXbpLqUQvs0qhgLyKxdT0cMz8=5kaDdMwoL46Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Excuse me,
I have one question when using device tree to get resource_size for
IORESOURCE_IRQ

Without dt,
static struct resource
{
                .start  = 18,
                .end    = 19,
                .flags  = IORESOURCE_IRQ,
},
iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
resource_size(iores) = 2 can be used to get how many irq.
iores->start = 18; iores->end = 19;

With dt,
interrupts = <18 19>;
The irq can only be parsed one by one.
iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0) ->
iores->start = 18; resource_size(iores) = 1.
iores = platform_get_resource(pdev, IORESOURCE_IRQ, 1) ->
iores->start = 19; resource_size(iores) = 1.
So resource_size(iores) can not be used to parse irq number
from IORESOURCE_IRQ.

Is there any API directly get resource number in dt, like resource_size(iores).
The reason is interrupts is not constant, and we want to parse
directly from resource.
If only one irq, then driver parse irqs internally.
Only if irq number same as channel number, then every channel have own irq.
It seems inconvenient get irq number one by one and check whether they
equals channel number or not.

Thanks
