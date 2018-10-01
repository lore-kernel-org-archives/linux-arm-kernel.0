From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 1 Oct 2018 18:44:14 +0100
Subject: [PATCH v8 2/9] KVM: arm/arm64: Share common code in
 user_mem_abort()
In-Reply-To: <20181001155443.23032-3-punit.agrawal@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
 <20181001155443.23032-3-punit.agrawal@arm.com>
Message-ID: <e7b9cc5a-594c-42c8-a36b-931370a0e817@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2018 04:54 PM, Punit Agrawal wrote:
> The code for operations such as marking the pfn as dirty, and
> dcache/icache maintenance during stage 2 fault handling is duplicated
> between normal pages and PMD hugepages.
> 
> Instead of creating another copy of the operations when we introduce
> PUD hugepages, let's share them across the different pagesizes.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
