From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Oct 2013 08:57:13 -0400
Subject: linux-next: manual merge of the arm-soc tree with the
 devicetree tree
In-Reply-To: <20131031192354.32945644fbdca2e0d6ca5455@canb.auug.org.au>
References: <20131031192354.32945644fbdca2e0d6ca5455@canb.auug.org.au>
Message-ID: <20131031125713.GK26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

Glad to see you're back at it!  Nice meeting you and your wife in
Edinburgh.

Adding Thomas Petazzoni to the Cc.

On Thu, Oct 31, 2013 at 07:23:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/pci/host/pci-mvebu.c between commit 16b84e5a505c ("of/irq: Create
> of_irq_parse_and_map_pci() to consolidate arch code.") from the
> devicetree tree and commit e5615c30c1c9 ("PCI: mvebu: remove
> subsys_initcall") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

This looks fine by me.

thx,

Jason.

> diff --cc drivers/pci/host/pci-mvebu.c
> index 07ddb3a13c6e,80b2250ea19a..000000000000
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@@ -693,9 -732,10 +719,10 @@@ static void mvebu_pcie_enable(struct mv
>   	hw.private_data   = (void **)&pcie;
>   	hw.setup          = mvebu_pcie_setup;
>   	hw.scan           = mvebu_pcie_scan_bus;
>  -	hw.map_irq        = mvebu_pcie_map_irq;
>  +	hw.map_irq        = of_irq_parse_and_map_pci;
>   	hw.ops            = &mvebu_pcie_ops;
>   	hw.align_resource = mvebu_pcie_align_resource;
> + 	hw.add_bus        = mvebu_pcie_add_bus;
>   
>   	pci_common_init(&hw);
>   }
