From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Sep 2015 11:19:57 +0100
Subject: [PATCH v3 2/7] irqchip/acpi: Add probing infrastructure for
 ACPI-based irqchips
In-Reply-To: <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150929101956.GC30504@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 03:49:13PM +0100, Marc Zyngier wrote:
> DT enjoys a rather nice probing infrastructure for irqchips, while
> ACPI is so far stuck into a very distant past.
> 
> This patch introduces a declarative API, allowing irqchips to be
> self-contained and be called when a particular entry is matched
> in the MADT table.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/irq.h      | 11 -----------
>  drivers/irqchip/irqchip.c         |  8 +++++---
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/acpi_irq.h          | 10 ----------
>  include/linux/irqchip.h           | 17 +++++++++++++++++
>  5 files changed, 23 insertions(+), 24 deletions(-)
>  delete mode 100644 include/linux/acpi_irq.h

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
