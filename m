From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Jan 2018 13:53:56 +0000
Subject: [PATCH] arm64: mm: Add additional parameter to
 uaccess_ttbr0_enable
In-Reply-To: <20180109134326.17479-1-christoffer.dall@linaro.org>
References: <20180109134326.17479-1-christoffer.dall@linaro.org>
Message-ID: <3e459188-f759-6f13-7ab4-1597c6da00a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/18 13:43, Christoffer Dall wrote:
> Add an extra temporary register parameter to uaccess_ttbr0_enable which
> is about to be required for arm64 PAN support.
> 
> This patch doesn't introduce any functional change but ensures that the
> kernel compiles once the KVM/ARM tree is merged with the arm64 tree by
> ensuring a trivially mergable conflict.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Maybe worth adding that this matches
27a921e75711d924617269e0ba4adb8bae9fd0d1 ("arm64: mm: Fix and re-enable
ARM64_SW_TTBR0_PAN")?

Otherwise:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for taking care of this.

	M.
-- 
Jazz is not dead. It just smells funny...
