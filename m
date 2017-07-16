From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 16 Jul 2017 21:13:47 +0100
Subject: [PATCH] irqchip/gic: Use GIC_SPI symbolic constant
In-Reply-To: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr> (Mason's message
 of "Sun, 16 Jul 2017 19:40:06 +0200")
References: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr>
Message-ID: <86shhwywas.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 16 2017 at  7:40:06 pm BST, Mason <slash.tmp@free.fr> wrote:
> Use GIC_SPI explicitly instead of an implicit 0.

What bug is this fixing? What benefit does this bring?

>
> Signed-off-by: Mason <slash.tmp@free.fr>
> ---
> FWIW, 'make C=2' flagged a few lines:
>
> $ make C=2 drivers/irqchip/irq-gic.o
>   CHECK   drivers/irqchip/irq-gic.c
> drivers/irqchip/irq-gic.c:1079:44: warning: incorrect type in assignment (different address spaces)
> drivers/irqchip/irq-gic.c:1079:44:    expected void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
> drivers/irqchip/irq-gic.c:1079:44:    got void [noderef] <asn:2>*[noderef] <asn:3>*<noident>

How is that related to this patch?

	M.
-- 
Jazz is not dead. It just smells funny.
