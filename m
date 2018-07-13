From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Jul 2018 16:27:37 +0100
Subject: [PATCH 0/3] PCI: mvebu: cleanup and improvements
In-Reply-To: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180713152737.GB18555@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 11:10:04AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> The main goal of this series is to convert the pci-mvebu driver to use
> the pci_host_bridge API directly instead of using the ARM-specific
> pci_common_init_dev() API. After this series, the last remaining user
> of pci_common_init_dev() is pci-rcar-gen2.
> 
> I would appreciate some careful review of the MEM and IO resource
> related changes (i.e the new mvebu_pcie_parse_request_resources()
> function), since the mvebu driver is a bit special in that respect,
> and cannot use the standard devm_of_pci_get_host_bridge_resources()
> API.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   PCI: mvebu: Remove redundant platform_set_drvdata() call
>   PCI: mvebu: Convert to use pci_host_bridge directly
>   PCI: mvebu: Drop bogus comment above mvebu_pcie_map_registers()
> 
>  drivers/pci/controller/pci-mvebu.c | 152 +++++++++++++++++--------------------
>  1 file changed, 71 insertions(+), 81 deletions(-)

Hi Thomas,

it does not apply cleanly to v4.18-rc1, can you please rebase it
and send it again so that I can apply it ?

Thanks,
Lorenzo
