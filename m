From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Nov 2015 09:43:04 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151118094303.GB27495@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 09:53:31AM +0100, Ard Biesheuvel wrote:
> As pointed out by Russell King in response to the proposed ARM version
> of this code, the sequence to switch between the UEFI runtime mapping
> and current's actual userland mapping (and vice versa) is potentially
> unsafe, since it leaves a time window between the switch to the new
> page tables and the TLB flush where speculative accesses may hit on
> stale global TLB entries.
> 
> So instead, use non-global mappings, and perform the switch via the
> ordinary ASID-aware context switch routines.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/mmu_context.h |  2 +-
>  arch/arm64/kernel/efi.c              | 14 +++++---------
>  2 files changed, 6 insertions(+), 10 deletions(-)

Patch applied. Thanks.

-- 
Catalin
