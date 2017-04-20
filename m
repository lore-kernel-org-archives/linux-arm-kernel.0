From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Apr 2017 11:33:40 +0100
Subject: [PATCH v4 03/21] ARM64: implement pci_remap_cfgspace() interface
In-Reply-To: <20170419164913.19674-4-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <20170419164913.19674-4-lorenzo.pieralisi@arm.com>
Message-ID: <20170420103340.GA755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 05:48:52PM +0100, Lorenzo Pieralisi wrote:
> The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> and Posting") defines rules for PCI configuration space transactions
> ordering and posting, that state that configuration writes
> are non-posted transactions.
> 
> This rule is reinforced by the ARM v8 architecture reference manual
> (issue A.k, Early Write Acknowledgment) that explicitly recommends
> that No Early Write Acknowledgment attribute should be used to map
> PCI configuration (write) transactions.
> 
> Current ioremap interface on ARM64 implements mapping functions
> where the Early Write Acknowledgment hint is enabled, so they
> cannot be used to map PCI configuration space in a PCI specs
> compliant way.
> 
> Implement an ARM64 specific pci_remap_cfgspace() interface
> that allows to map PCI config region with nGnRnE attributes, providing
> a remap function that complies with PCI specifications and the ARMv8
> architecture reference manual recommendations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
