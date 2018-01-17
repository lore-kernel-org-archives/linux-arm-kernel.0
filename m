From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Jan 2018 12:57:32 +0000
Subject: [PATCH] arm64: mm: Add additional parameter to
 uaccess_ttbr0_disable
In-Reply-To: <20180117113850.21949-1-christoffer.dall@linaro.org>
References: <20180117113850.21949-1-christoffer.dall@linaro.org>
Message-ID: <bd24a127-4215-d7a5-64f8-b79a05bc9a47@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/18 11:38, Christoffer Dall wrote:
> Add an extra temporary register parameter to uaccess_ttbr0_disable which
> is about to be required for arm64 PAN support.
> 
> This patch doesn't introduce any functional change but ensures that the
> kernel compiles once the KVM/ARM tree is merged with the arm64 tree by
> ensuring a trivially mergable conflict with commit
> 6b88a32c7af68895134872cdec3b6bfdb532d94e
> ("arm64: kpti: Fix the interaction between ASID switching and software PAN").
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 8 ++++----
>  arch/arm64/lib/clear_user.S          | 2 +-
>  arch/arm64/lib/copy_from_user.S      | 2 +-
>  arch/arm64/lib/copy_in_user.S        | 2 +-
>  arch/arm64/lib/copy_to_user.S        | 2 +-
>  arch/arm64/mm/cache.S                | 4 ++--
>  arch/arm64/xen/hypercall.S           | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
