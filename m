From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 3 Jan 2014 11:59:07 -0700
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140103185907.GD12098@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 10:59:44AM +0100, Gregory CLEMENT wrote:

> +		/* SoC ID */
> +		soc_dev_id = __raw_readl(pci_base + PCIE_DEV_ID_OFF) >> 16;
> +
> +		/* SoC revision */
> +		soc_rev = __raw_readl(pci_base + PCIE_DEV_REV_OFF)
> +			& SOC_REV_MASK;

Sort of a minor nit, but I'm not actually sure these registers are
read-only :( I know the documentation doesn't describe how to change
them, but in PCI-E EndPoint mode they are read by the host so the
firmware must be able to change them to reflect the firmware running
on the endpoint..

Which is to say, I suppose the bootloader could program them to
something else if it wanted to.

That said, in practice obviously they will not be changed, but maybe
there is another ID register you can read?

Jason
