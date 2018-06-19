From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 12:44:08 +0100
Subject: [PATCHv3 03/19] arm64: introduce sysreg_clear_set()
In-Reply-To: <20180618120310.39527-4-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-4-mark.rutland@arm.com>
Message-ID: <20180619114407.xewj22zxk3kusu55@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:54PM +0100, Mark Rutland wrote:
> Currently we have a couple of helpers to manipulate bits in particular
> sysregs:
> 
>  * config_sctlr_el1(u32 clear, u32 set)
> 
>  * change_cpacr(u64 val, u64 mask)
> 
> The parameters of these differ in naming convention, order, and size,
> which is unfortunate. They also differ slightly in behaviour, as
> change_cpacr() skips the sysreg write if the bits are unchanged, which
> is a useful optimization when sysreg writes are expensive.
> 
> Before we gain more yet another sysreg manipulation function, let's
> unify these with a common helper, providing a consistent order for
> clear/set operands, and the write skipping behaviour from
> change_cpacr(). Code will be migrated to the new helper in subsequent
> patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
