From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 12:08:25 -0700
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121210190825.GC4687@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 11:04:31PM +0100, Thomas Petazzoni wrote:

> +static void __devinit rc_pci_fixup(struct pci_dev *dev)
> +{
> +	/*
> +	 * Prevent enumeration of root complex.
> +	 */
> +	if (dev->bus->parent == NULL && dev->devfn == 0) {
> +		int i;
> +
> +		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +			dev->resource[i].start = 0;
> +			dev->resource[i].end   = 0;
> +			dev->resource[i].flags = 0;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);

You should grab my fixup for this function in the kirkwood code:

1dc831bf53fddcc6443f74a39e72db5bcea4f15d

Regards,
Jason
