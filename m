From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 13:00:27 +0100
Subject: [PATCHv3 06/19] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
In-Reply-To: <20180618120310.39527-7-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-7-mark.rutland@arm.com>
Message-ID: <20180619120026.jn2v7bbszeyizujy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:57PM +0100, Mark Rutland wrote:
> In subsequent patches, we'll want to make use of sve_user_enable() and
> sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
> <asm/fpsimd.h> where we can make use of them.
> 
> To avoid ifdeffery in sequences like:
> 
> if (system_supports_sve() && some_condition
> 	sve_user_disable();
> 
> ... empty stubs are provided when support for SVE is not enabled. Note
> that system_supports_sve() contains as IS_ENABLED(CONFIG_ARM64_SVE), so
> the sve_user_disable() call should be optimized away entirely when
> CONFIG_ARM64_SVE is not selected.
> 
> To ensure that this is the case, the stub definitions contain a
> BUILD_BUG(), as we do for other stubs for which calls should always be
> optimized away when the relevant config option is not selected.
> 
> At the same time, the include list of <asm/fpsimd.h> is sorted while
> adding <asm/sysreg.h>.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
