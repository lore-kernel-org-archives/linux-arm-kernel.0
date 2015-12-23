From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Dec 2015 12:23:19 +0100
Subject: [PATCH 3/4] irqchip: irq-armada-370-xp: use shorter names for
 irq_chip
In-Reply-To: <1450707546-15060-4-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Mon, 21 Dec 2015 15:19:05 +0100")
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <871tadfly0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> In order to make the output of /proc/interrupts, use shorter names for
                                                 ^
                    in order to make it what ?---|
> the irq_chip registered by the irq-armada-370-xp driver. Using capital
> letters also matches better what is done for the GIC driver, which
> uses just "GIC" as the irq_chip->name.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 304166b..31a183d 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -117,7 +117,7 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
>  #ifdef CONFIG_PCI_MSI
>  
>  static struct irq_chip armada_370_xp_msi_irq_chip = {
> -	.name = "armada_370_xp_msi_irq",
> +	.name = "MSI MPIC",
>  	.irq_enable = pci_msi_unmask_irq,
>  	.irq_disable = pci_msi_mask_irq,
>  	.irq_mask = pci_msi_mask_irq,
> @@ -144,7 +144,7 @@ static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
>  }
>  
>  static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
> -	.name			= "MPIC MSI",
> +	.name			= "MSI MPIC",
>  	.irq_compose_msi_msg	= armada_370_xp_compose_msi_msg,
>  	.irq_set_affinity	= armada_370_xp_msi_set_affinity,
>  };
> @@ -256,7 +256,7 @@ static int armada_xp_set_affinity(struct irq_data *d,
>  #endif
>  
>  static struct irq_chip armada_370_xp_irq_chip = {
> -	.name		= "armada_370_xp_irq",
> +	.name		= "MPIC",

MPIC is the name also used by the power PC interrupt controller, so it
would be confusing to use exactly the same name.

What about calling it "MRVL MPIC" or "MVEBU MPIC"?
the name remains short but it won't be confused with the power PC ones.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
