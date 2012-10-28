From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Oct 2012 08:23:54 -0500
Subject: [PATCH v2] Introduce minimal irqchip infrastructure
In-Reply-To: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508D31EA.3050307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 04:30 AM, Thomas Petazzoni wrote:
> Thomas, Rob, Arnd,
> 
> Here is a small set of patches that introduces a small irqchip
> infrastructure that allows the registration of irqchip drivers without
> having each of those drivers to expose a public API in
> include/linux/irqchip/ (patch 1/4), moves the only existing irqchip
> driver, irq-bcm2835 to this infrastructure (patch 2/4), moves the
> irqchip driver for the Armada 370 / Armada XP SoCs to the
> drivers/irqchip directory (patch 3/4) and finally adds the
> drivers/irqchip directory to the IRQ subsystem entry in the
> MAINTAINERS file (patch 4/4).
> 
> Changes since v1:
> 
>  * Add a new patch mentionning the drivers/irqchip in the list of
>    directories part of the IRQ subsystem maintained by Thomas Gleixner
>    in the MAINTAINERS file. Requested by Arnd Bergmann.
> 
>  * Reduce the amount of code movement in the irq-bcm2835.c and
>    irq-armada-370-xp.c files by using one forward declaration for the
>    IRQ handling entry point. Requested by Stephen Warren.
> 
>  * Rename the armctrl_of_init() function to bcm2835_irqchip_init() as
>    requested by Stephen Warren.
> 
>  * Added the formal Acked-by and Reviewed-by received from Stephen
>    Warren.

Other than the 2 minor things I mentioned, this series looks good.

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Also, I have some follow-on patches to move the GIC and VIC to
drivers/irqchip. It was much more simple than I expected. I'll post them
later.

Rob
