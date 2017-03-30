From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 17:20:16 +0100
Subject: [PATCH v2 07/22] PCI: ECAM: use ioremap_nopost() to map config
 region
In-Reply-To: <20170327094954.7162-8-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-8-lorenzo.pieralisi@arm.com>
Message-ID: <20170330162015.GB5623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 10:49:35AM +0100, Lorenzo Pieralisi wrote:
> Current ECAM kernel implementation uses ioremap() to map the ECAM
> configuration space memory region; this is not safe in that on some
> architectures the ioremap interface provides mappings that allow posted
> write transactions. This, as highlighted in the PCIe specifications
> (4.0 - Rev0.3, "Ordering Considerations for the Enhanced Configuration
> Address Mechanism"), can create ordering issues for software because
> posted writes transactions on the CPU host bus are non posted in the
> PCI express fabric.
> 
> Update the ioremap() interface to use ioremap_nopost() whose
> mapping attributes guarantee that non-posted writes transactions
> are issued for memory writes within the ECAM memory mapped address
> region.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ecam.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
