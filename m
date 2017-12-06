From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Dec 2017 12:17:16 +0000
Subject: [PATCH 2/2] arm64: SW PAN: Update saved ttbr0 value on
 enter_lazy_tlb
In-Reply-To: <1512558968-28980-3-git-send-email-will.deacon@arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
 <1512558968-28980-3-git-send-email-will.deacon@arm.com>
Message-ID: <20171206121715.tnsp7ycrc7idksoj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:16:08AM +0000, Will Deacon wrote:
> enter_lazy_tlb is called when a kernel thread rides on the back of
> another mm, due to a context switch or an explicit call to unuse_mm
> where a call to switch_mm is elided.
> 
> In these cases, it's important to keep the saved ttbr value up to date
> with the active mm, otherwise we can end up with a stale value which
> points to a potentially freed page table.
> 
> This patch implements enter_lazy_tlb for arm64, so that the saved ttbr0
> is kept up-to-date with the active mm for kernel threads.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Vinayak Menon <vinmenon@codeaurora.org>
> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
