From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 09 Mar 2010 16:45:34 +0000
Subject: [PATCH 2/2] arm: invalidate TLBs when enabling mmu
In-Reply-To: <1268143623-22361-3-git-send-email-saeed@marvell.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
	<1268143623-22361-3-git-send-email-saeed@marvell.com>
Message-ID: <1268153134.1000.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-09 at 14:07 +0000, Saeed Bishara wrote:
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  arch/arm/boot/compressed/head.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S
> b/arch/arm/boot/compressed/head.S
> index 4fddc50..a1ab79f 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -489,6 +489,7 @@ __armv7_mmu_cache_on:
>                 mcr     p15, 0, r0, c1, c0, 0   @ load control
> register
>                 mrc     p15, 0, r0, c1, c0, 0   @ and read it back
>                 mov     r0, #0
> +               mcr     p15, 0, r0, c8, c7, 0   @ invalidate I,D TLBs
>                 mcr     p15, 0, r0, c7, c5, 4   @ ISB
>                 mov     pc, r12

The TLB invalidating is done earlier in the __armv7_mmu_cache_on
function, why do you need to do it again?

-- 
Catalin
