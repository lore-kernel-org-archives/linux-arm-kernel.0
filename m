From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 13:47:49 +0100
Subject: [PATCHv3 07/19] arm64: remove sigreturn wrappers
In-Reply-To: <20180618120310.39527-8-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-8-mark.rutland@arm.com>
Message-ID: <20180619124749.xxxmfuasqhefx7n6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:58PM +0100, Mark Rutland wrote:
> The arm64 sigreturn* syscall handlers are non-standard. Rather than
> taking a number of user parameters in registers as per the AAPCS,
> they expect the pt_regs as their sole argument.
> 
> To make this work, we override the syscall definitions to invoke
> wrappers written in assembly, which mov the SP into x0, and branch to
> their respective C functions.
> 
> On other architectures (such as x86), the sigreturn* functions take no
> argument and instead use current_pt_regs() to acquire the user
> registers. This requires less boilerplate code, and allows for other
> features such as interposing C code in this path.
> 
> This patch takes the same approach for arm64.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tentatively-reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
