From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Oct 2018 11:50:38 +0100
Subject: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for
 adjustment
In-Reply-To: <20181001155443.23032-2-punit.agrawal@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
 <20181001155443.23032-2-punit.agrawal@arm.com>
Message-ID: <0809a9d0-d256-c23a-c3cc-0b2be33aecff@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/18 16:54, Punit Agrawal wrote:
> PageTransCompoundMap() returns true for hugetlbfs and THP
> hugepages. This behaviour incorrectly leads to stage 2 faults for
> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
> treated as THP faults.
> 
> Tighten the check to filter out hugetlbfs pages. This also leads to
> consistently mapping all unsupported hugepage sizes as PTE level
> entries at stage 2.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: stable at vger.kernel.org # v4.13+

FWIW, I've cherry-picked that single patch from the series and queued it 
for 4.20.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
