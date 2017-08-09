From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 15:31:08 +0100
Subject: [PATCH] arm64: neon: Forbid when irqs are disabled
In-Reply-To: <1502275408-16982-1-git-send-email-Dave.Martin@arm.com>
References: <1502275408-16982-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170809143108.6bvo3jw275uoylyy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 11:43:28AM +0100, Dave P Martin wrote:
> Currently, may_use_simd() can return true if IRQs are disabled.  If
> the caller goes ahead and calls kernel_neon_begin(), this can
> result in use of local_bh_enable() in an unsafe context.
> 
> In particular, __efi_fpsimd_begin() may do this when calling EFI as
> part of system shutdown.
> 
> This patch ensures that callers don't think they can use
> kernel_neon_begin() in such a context.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks. I pushed it out to the for-next/kernel-mode-neon branch.

-- 
Catalin
