From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 08 Jun 2011 10:17:38 +0100
Subject: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
In-Reply-To: <1307522062-19273-5-git-send-email-ohad@wizery.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-5-git-send-email-ohad@wizery.com>
Message-ID: <1307524659.4771.12.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-08 at 11:34 +0300, Ohad Ben-Cohen wrote:
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_PCI_MSI) += msi.o
>  obj-$(CONFIG_HT_IRQ) += htirq.o
>  
>  # Build Intel IOMMU support
> -obj-$(CONFIG_DMAR) += dmar.o iova.o intel-iommu.o
> +obj-$(CONFIG_DMAR) += dmar.o iova.o
>  
>  obj-$(CONFIG_INTR_REMAP) += dmar.o intr_remapping.o
>  

At least iova.o wants to go with it. That's one of the parts that is a
candidate for harmonisation across IOMMU implementations, either by
removing it or by having others use it too. It's how we allocate virtual
I/O address space.

I suspect the interrupt remapping support may well want to move with it
too. It's no more out-of-place in drivers/iommu than it is in
drivers/pci. And then you can certainly move dmar.o too.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
