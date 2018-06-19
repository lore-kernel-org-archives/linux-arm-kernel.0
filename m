From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:48:29 +0100
Subject: [PATCHv3 16/19] arm64: use {COMPAT, }SYSCALL_DEFINE0 for sigreturn
In-Reply-To: <20180618120310.39527-17-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-17-mark.rutland@arm.com>
Message-ID: <20180619154828.fznuzffhslsvxqqj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:07PM +0100, Mark Rutland wrote:
> We don't currently annotate our various sigreturn functions as syscalls,
> as we need to do to use pt_regs syscall wrappers.
> 
> Let's mark them as real syscalls.
> 
> For compat_sys_sigreturn and compat_sys_rt_sigreturn, this changes the
> return type from int to long, matching the prototypes in sys32.c.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
