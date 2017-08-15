From: sr@denx.de (Stefan Roese)
Date: Tue, 15 Aug 2017 15:31:31 +0200
Subject: [PATCH] irqchip/armada-370-xp: Enable MSI-X support
In-Reply-To: <20170502072600.13380-1-sr@denx.de>
References: <20170502072600.13380-1-sr@denx.de>
Message-ID: <80f30724-20b6-b5a7-7218-93ff3fa23177@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 02.05.2017 09:26, Stefan Roese wrote:
> Armada XP does not only support MSI, but also MSI-X. This patch sets
> the MSI_FLAG_PCI_MSIX flag in the interrupt controller driver which
> is the only change necessary to enable MSI-X support on this SoC. As
> the Linux PCI MSI-X infrastructure takes care of writing the data and
> address structures into the BAR specified by the MSI-X controller.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/irqchip/irq-armada-370-xp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 33982cbd8a57..b17039ed8735 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -124,7 +124,7 @@ static struct irq_chip armada_370_xp_msi_irq_chip = {
>   
>   static struct msi_domain_info armada_370_xp_msi_domain_info = {
>   	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_MULTI_PCI_MSI),
> +		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
>   	.chip	= &armada_370_xp_msi_irq_chip,
>   };
>   
> 

Its been a while since this patch has been submitted - without any
comments so far. What's the current status with it? Is it someones
queue for upstreaming?

Thanks,
Stefan
