From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Oct 2017 17:19:14 +0100
Subject: [PATCH v3 3/9] arm64: KVM: Add invalidate_icache_range helper
In-Reply-To: <20171023161122.15291-4-marc.zyngier@arm.com>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
 <20171023161122.15291-4-marc.zyngier@arm.com>
Message-ID: <20171023161914.GA6222@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 05:11:16PM +0100, Marc Zyngier wrote:
> We currently tightly couple dcache clean with icache invalidation,
> but KVM could do without the initial flush to PoU, as we've
> already flushed things to PoC.
> 
> Let's introduce invalidate_icache_range which is limited to
> invalidating the icache from the linear mapping (and thus
> has none of the userspace fault handling complexity), and
> wire it in KVM instead of flush_icache_range.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h  | 21 +++++++++++++++++++++
>  arch/arm64/include/asm/cacheflush.h |  7 +++++++
>  arch/arm64/include/asm/kvm_mmu.h    |  4 ++--
>  arch/arm64/mm/cache.S               | 32 ++++++++++++++++++++++----------
>  4 files changed, 52 insertions(+), 12 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for respinning this.

Will
