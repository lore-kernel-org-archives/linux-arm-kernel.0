From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 14:33:24 +0100
Subject: [PATCHv3 08/19] arm64: convert raw syscall invocation to C
In-Reply-To: <20180618120310.39527-9-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-9-mark.rutland@arm.com>
Message-ID: <20180619133324.kaetvwje3xjazyp6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:59PM +0100, Mark Rutland wrote:
> As a first step towards invoking syscalls with a pt_regs argument,
> convert the raw syscall invocation logic to C. We end up with a bit more
> register shuffling, but the unified invocation logic means we can unify
> the tracing paths, too.
> 
> Previously, assembly had to open-code calls to ni_sys() when the system
> call number was out-of-bounds for the relevant syscall table. This case
> is now handled by invoke_syscall(), and the assembly no longer need to
> handle this case explicitly. This allows the tracing paths to be
> simplfiied and unified, as we no longer need the __ni_sys_trace path and

'simplified'

> the __sys_trace_return label.
> 
> This only converts the invocation of the syscall. The rest of the
> syscall triage and tracing is left in assembly for now, and will be
> converted in subsequent patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
