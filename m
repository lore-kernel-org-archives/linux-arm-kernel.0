From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Sep 2014 07:54:03 -0700
Subject: [PATCH 0/9] arm: omap: intc: remaining patches
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Message-ID: <20140917145402.GC7987@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140915 14:16]:
> Hi Tony,
> 
> Here are the remaining INTC patches rebased on your omap-for-v3.18/intc-v2
> branch.
> 
> Based on our IRC chat, I kept irq-omap-intc.h header, but included it
> on common.h instead of modifying every board-file.

Great thanks. We can deal with common.h header once we've dropped
the legacy board-*.c files for omap3.

Applying all into omap-for-v3.18/intc-v2.

Regards,

Tony
 
> cheers
> 
> Felipe Balbi (9):
>   irqchip: add irq-omap-intc.h header
>   arm: omap: irq: move irq.c to drivers/irqchip/
>   irqchip: omap-intc: minor improvement to omap_irq_pending()
>   irqchip: omap-intc: comment style cleanup
>   irqchip: omap-intc: remove unnecesary of_address_to_resource() call
>   irqchip: omap-intc: enable IP protection
>   irqchip: omap-intc: enable TURBO idle mode
>   irqchip: omap-intc: correct maximum number or MIR registers
>   irqchip: omap-intc: remove unnecessary comments
> 
>  arch/arm/mach-omap2/Kconfig                        |  1 +
>  arch/arm/mach-omap2/Makefile                       |  3 +-
>  arch/arm/mach-omap2/common.h                       | 10 +---
>  drivers/irqchip/Kconfig                            |  5 ++
>  drivers/irqchip/Makefile                           |  1 +
>  .../irq.c => drivers/irqchip/irq-omap-intc.c       | 64 +++++++++++++---------
>  include/linux/irqchip/irq-omap-intc.h              | 32 +++++++++++
>  7 files changed, 78 insertions(+), 38 deletions(-)
>  rename arch/arm/mach-omap2/irq.c => drivers/irqchip/irq-omap-intc.c (89%)
>  create mode 100644 include/linux/irqchip/irq-omap-intc.h
> 
> -- 
> 2.0.1.563.g66f467c
> 
