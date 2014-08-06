From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Aug 2014 10:30:21 -0600
Subject: [PATCH] PCI: keystone: add a pci quirk to limit mrrs
In-Reply-To: <1407338300-9146-1-git-send-email-m-karicheri2@ti.com>
References: <1407338300-9146-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <20140806163021.GB19914@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 11:18:20AM -0400, Murali Karicheri wrote:
> Keystone PCI controller has a limitation that memory read request
> size must not exceed 256 bytes. This is a hardware limitation and
> add a quirk to force this limit on all downstream devices by
> updating mrrs.

Does this still work if the tuning is enabled, or does the tuning run
after this?

> +			if (pcie_get_readrq(dev) > 256) {
> +				pr_info("limiting mrrs to 256\n");
> +				pcie_set_readrq(dev, 256);

The pr_info should either go away, or at least print the PCI bdf..

Jason
