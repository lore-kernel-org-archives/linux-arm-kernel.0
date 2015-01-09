From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 9 Jan 2015 11:31:48 -0700
Subject: [PATCH 2/20] PCI: keystone: fix misspelling of current function
 in string
In-Reply-To: <1417980062-25151-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
 <1417980062-25151-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20150109183148.GH6575@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 08:20:44PM +0100, Julia Lawall wrote:
> Replace a misspelled function name by %s and then __func__.
> 
> The function name contains pcie, not pci as in the string.
> 
> This was done using Coccinelle, including the use of Levenshtein distance,
> as proposed by Rasmus Villemoes.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied with Murali's ack to pci/host-keystone for v3.20, thanks!

> ---
> The semantic patch is difficult to summarize, but is available in the cover
> letter of this patch series.
> 
>  drivers/pci/host/pci-keystone.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 78f79e3..e2f600e 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -119,7 +119,7 @@ static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	struct pcie_port *pp = &ks_pcie->pp;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> -	dev_dbg(pp->dev, "ks_pci_msi_irq_handler, irq %d\n", irq);
> +	dev_dbg(pp->dev, "%s, irq %d\n", __func__, irq);
>  
>  	/*
>  	 * The chained irq handler installation would have replaced normal
> 
