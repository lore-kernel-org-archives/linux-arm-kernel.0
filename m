From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Jul 2014 08:53:09 -0400
Subject: [PATCH 4/4 V3] irqchip: gicv2m: Add support for multiple MSI
 for ARM64 GICv2m
In-Reply-To: <1404947104-21345-5-git-send-email-suravee.suthikulpanit@amd.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1404947104-21345-5-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140717125309.GK13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suravee,

On Wed, Jul 09, 2014 at 06:05:04PM -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch extend GICv2m MSI to support multiple MSI in ARM64.
> 
> This requires the common arch_setup_msi_irqs() to be overwriten
> with ARM64 version which does not return 1 for PCI_CAP_ID_MSI and
> nvec > 1.
> 
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/arm64/include/asm/msi.h  | 15 ++++++++
>  arch/arm64/kernel/Makefile    |  1 +
>  arch/arm64/kernel/msi.c       | 57 ++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v2m.c | 80 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+)
>  create mode 100644 arch/arm64/include/asm/msi.h
>  create mode 100644 arch/arm64/kernel/msi.c

With the Subject line nit fixed ("irqchip: gic-v2m: ..."),

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please route as you see fit.

thx,

Jason.
