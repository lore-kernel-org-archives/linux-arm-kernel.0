From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 16 Jul 2018 13:46:43 +0100
Subject: [PATCH v6 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
In-Reply-To: <20180716110857.19310-3-punit.agrawal@arm.com>
References: <20180716110857.19310-1-punit.agrawal@arm.com>
 <20180716110857.19310-3-punit.agrawal@arm.com>
Message-ID: <ee0a72a5-ffa9-6016-80e7-0abc6d65f514@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/18 12:08, Punit Agrawal wrote:
> Stage 2 fault handler marks a page as executable if it is handling an
> execution fault or if it was a permission fault in which case the
> executable bit needs to be preserved.
> 
> The logic to decide if the page should be marked executable is
> duplicated for PMD and PTE entries. To avoid creating another copy
> when support for PUD hugepages is introduced refactor the code to
> share the checks needed to mark a page table entry as executable.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
