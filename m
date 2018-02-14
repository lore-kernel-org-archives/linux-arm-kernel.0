From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 14 Feb 2018 19:22:36 +0100
Subject: [PATCH] arm64: Move post_ttbr_update_workaround to C code
In-Reply-To: <20180214155140.27162-1-ard.biesheuvel@linaro.org>
References: <20180214154033.GA2745@kroah.com>
 <20180214155140.27162-1-ard.biesheuvel@linaro.org>
Message-ID: <20180214182236.GA4611@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 03:51:40PM +0000, Ard Biesheuvel wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Commit 95e3de3590e3 upstream.
> 
> We will soon need to invoke a CPU-specific function pointer after changing
> page tables, so move post_ttbr_update_workaround out into C code to make
> this possible.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/assembler.h | 13 -------------
>  arch/arm64/kernel/entry.S          |  2 +-
>  arch/arm64/mm/context.c            |  9 +++++++++
>  arch/arm64/mm/proc.S               |  3 +--
>  4 files changed, 11 insertions(+), 16 deletions(-)

Thanks, now applied.

greg k-h
