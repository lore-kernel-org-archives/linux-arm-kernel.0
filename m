From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 14 Mar 2017 15:15:24 -0500
Subject: [PATCH v3 0/3] pci: remove msi_controller registration API
In-Reply-To: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170314201524.GF26264@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 03:31:13PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This small patch series aims at removing the small msi_controller
> registration API implemented in drivers/of/of_pci.c.
> 
> In order to do so, it moves the last two users of this API to the
> generic MSI support:
> 
>  - The pci-aardvark driver is moved to use the generic MSI
>    support. This driver is both the provider of the MSI capability and
>    the consumer of this capability.
> 
>  - The pci-mvebu driver is cleaned up from using the msi_controller
>    registration API. This driver is only consuming MSI capabilies from
>    another driver (irq-armada-370-xp) which was migrated to the
>    generic MSI support some time ago. Therefore, this patch is simply
>    removing dead code.
> 
> Finally, the last commit removed the now unused API.
> 
> Changes between v2 and v3 are described in each individual patch.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   pci: pci-aardvark: move to MSI handling using generic MSI support
>   pci: pci-mvebu: remove useless MSI enabling code
>   of: pci: remove unused MSI controller helpers
> 
>  drivers/of/of_pci.c             |  45 -----------
>  drivers/pci/host/pci-aardvark.c | 173 ++++++++++++++++------------------------
>  drivers/pci/host/pci-mvebu.c    |  17 ----
>  include/linux/of_pci.h          |  11 ---
>  4 files changed, 67 insertions(+), 179 deletions(-)

Applied to pci/msi for v4.12, thanks!

I think Marc's ack on 1/30 applies to the first two, so I added it to them.

Oh, and I'll drop the other aardvark change that removes the same bits of
unused "msi-parent" code from advk_pcie_probe().

Bjorn
