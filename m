From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 18:29:42 +0100
Subject: [PATCH] arm64: neon/efi: Make EFI fpsimd save/restore variables
 static
In-Reply-To: <1503064427-4352-1-git-send-email-Dave.Martin@arm.com>
References: <1503064427-4352-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170818172942.4ail76h6qndb25bp@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 02:53:47PM +0100, Dave P Martin wrote:
> The percpu variables efi_fpsimd_state and efi_fpsimd_state_used,
> used by the FPSIMD save/restore routines for EFI calls, are
> unintentionally global.
> 
> There's no reason for anything outside fpsimd.c to touch these, so
> this patch makes them static (as they should have been in the first
> place).
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Applied to for-next/kernel-mode-neon. Thanks.

-- 
Catalin
