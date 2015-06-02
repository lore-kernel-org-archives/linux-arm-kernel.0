From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Jun 2015 18:47:15 +0100
Subject: [PATCH v2 0/4] arm64: alternative patching rework
In-Reply-To: <1433152062-21907-1-git-send-email-marc.zyngier@arm.com>
References: <1433152062-21907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150602174715.GE3080@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:47:38AM +0100, Marc Zyngier wrote:
> The current alternative instruction framework is not kind to branches,
> potentially leading to all kind of hacks in the code that uses
> alternatives. This series expands it to deal with immediate and
> conditional branches.
> 
> This is a rewrite of fef7f2b20103, which got reverted in b9a95e85bbc
> as it was breaking unsuspecting branches inside an alternate
> sequence. It now also deals with conditional branches (instead of just
> asserting a BUG).
> 
> Another nit is addressed by the last patch, where GAS gets confused by
> the combinaison of a .inst directive (as used by the msr_s/mrs_s
> pseudo-instruction), a label, and a .if directive evaluating said
> label. As this is exactly what the alternative framework uses to
> detect length mismatch, this patch reverts to using a pair of .org
> directives in a creative way. To make this a bit easier,
> alternative-asm.h is folded into alternative.h.
> 
> This has been tested on v4.1-rc5.
> 
> Marc Zyngier (4):
>   arm64: insn: Add aarch64_{get,set}_branch_offset
>   arm64: alternative: Allow immediate branch as alternative instruction
>   arm64: alternative: Merge alternative-asm.h into alternative.h
>   arm64: alternative: Work around .inst assembler bugs

Applied, thanks.

-- 
Catalin
