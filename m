From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Oct 2012 10:18:24 +0100
Subject: [PATCH v3 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <1351462748-5224-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351462748-5224-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508E49E0.8050606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 11:19 PM, Thomas Petazzoni wrote:
> Now that the drivers/irqchip/ directory has a minimal infrastructure
> to support the addition of irq controller driver, we move the irq
> controller driver for Armada 370 and Armada XP ARM SoCs from the
> arch/arm/mach-mvebu/ directory to the drivers/irqchip/ directory and
> update the irqchip infrastructure to take into account this new
> driver.
>
> [...]
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 6b5a6e0..5148ffd 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -1,2 +1,3 @@
>   obj-$(CONFIG_IRQCHIP) += irqchip.o
>   obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
> +obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o

Thomas,

using ARCH_MVEBU for enabling irq-armada-370-xp here will lead to
incompatibilities with Orion SoCs when they move over to ARCH_MVEBU.
Although, it is ok for the moment please choose either a CONFIG_
common for both Armada 370 and XP.

With a Kconfig within drivers/irqchip you could define a
ARMADA_370_XP_IRQ and select that in MACH_ARMADA_370 and MACH_ARMADA_XP
or MACH_ARMADA_370_XP, which all already exist.

As soon as the patch is through, I can provide (and use) a irq-orion
based on irqchip. I can provide it earlier but to actually use it there
are still some other patches required on Dove. Other Orions could
switch now, I guess.

Sebastian
