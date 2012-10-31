From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 15:09:54 +0000
Subject: [PATCH v2 3/5] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <1351695517-5636-4-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-4-git-send-email-robherring2@gmail.com>
Message-ID: <20121031150954.GN21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 09:58:35AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have drivers/irqchip, move GIC irqchip to drivers/irqchip. This
> is necessary to share the GIC with arm and arm64.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/common/Kconfig                            |    8 --------
>  arch/arm/common/Makefile                           |    1 -
>  drivers/irqchip/Kconfig                            |    8 ++++++++
>  drivers/irqchip/Makefile                           |    1 +
>  arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
>  drivers/irqchip/irqchip.c                          |   10 ++++++++++
>  drivers/irqchip/irqchip.h                          |    1 +
>  7 files changed, 20 insertions(+), 9 deletions(-)
>  rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (100%)

What about its dependent arch/arm/include/asm/hardware/gic.h header,
which I believe after patch 1 becomes just a bunch of function calls,
and so no longer has any right to be in asm/hardware.

Nothing should be moved out of arch/arm without its associated header
file also moving with it.
