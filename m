From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 17:19:31 +0100
Subject: [PATCH v2 05/22] ARM64: implement ioremap_nopost() interface
In-Reply-To: <20170327094954.7162-6-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-6-lorenzo.pieralisi@arm.com>
Message-ID: <20170330161931.GA5623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 10:49:33AM +0100, Lorenzo Pieralisi wrote:
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
> Implement an ARM64 specific ioremap_nopost() interface
> that allows to map PCI config region with nGnRnE attributes, providing
> a remap function that complies with PCI specifications and the ARMv8
> architecture reference manual recommendations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/io.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Let me know if you need this taken via the arm64 tree.

Will
