From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Jul 2018 13:59:38 +0100
Subject: [PATCH v5 1/7] KVM: arm/arm64: Share common code in
 user_mem_abort()
In-Reply-To: <20180709144124.29164-1-punit.agrawal@arm.com>
References: <20180709143835.28971-1-punit.agrawal@arm.com>
 <20180709144124.29164-1-punit.agrawal@arm.com>
Message-ID: <9470f63a-6e8c-aeb6-7648-ad5fc7f24904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/18 15:41, Punit Agrawal wrote:
> The code for operations such as marking the pfn as dirty, and
> dcache/icache maintenance during stage 2 fault handling is duplicated
> between normal pages and PMD hugepages.
> 
> Instead of creating another copy of the operations when we introduce
> PUD hugepages, let's share them across the different pagesizes.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   virt/kvm/arm/mmu.c | 67 ++++++++++++++++++++++++++--------------------
>   1 file changed, 38 insertions(+), 29 deletions(-)
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
