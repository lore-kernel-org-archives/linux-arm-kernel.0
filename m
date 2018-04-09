From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 9 Apr 2018 17:23:56 +0100
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
In-Reply-To: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180409162356.GB14533@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 04:55:30PM +0200, Thomas Petazzoni wrote:
> Bjorn, Lorenzo,
> 
> This patch series brings a number of improvements to the aardvark
> PCIe.

Hi Thomas,

it is not just improvements, these look like significant bug fixes too.

Let me know which patches we should prioritize since hopefully they can
be sent during v4.17-rc* releases, I will queue the rest for the next
merge window.

Thanks,
Lorenzo

> 
> Changes since v3:
> 
>  - Introduced advk_pcie_valid_device() late in the series, so that the
>    patch fixing the logic in the PCIe configuration space read/write
>    function does not depend on it. This is needed as we don't want the
>    advk_pcie_valid_device() addition to go to stable.
> 
> Changes since v2:
> 
>  - Rebased on v4.16-rc7
> 
>  - Dropped the patches disabling L0S and aligning the MPS between RC
>    and EP, since we are working on a different solution, implementing
>    a proper root port. Therefore, this patch series only has the
>    (hopefully) non-controversial changes.
> 
>  - Add a patch (PATCH 1) that factorizes the logic to decide if the
>    target of a configuration space access is a valid device or not
>    into a advk_pcie_valid_device() helper, and adjust PATCH 2
>    accordingly.
> 
>  - Drop unused PCIE_BDF macro in PATCH 3.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> 
> 
> Evan Wang (2):
>   PCI: aardvark: Fix PCIe Max Read Request Size setting
>   PCI: aardvark: Remove PCIe outbound window configuration
> 
> Thomas Petazzoni (1):
>   PCI: aardvark: Introduce an advk_pcie_valid_device() helper
> 
> Victor Gu (3):
>   PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
>   PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
>   PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode
> 
>  drivers/pci/host/pci-aardvark.c | 117 ++++++++++++++--------------------------
>  1 file changed, 39 insertions(+), 78 deletions(-)
> 
> -- 
> 2.14.3
> 
