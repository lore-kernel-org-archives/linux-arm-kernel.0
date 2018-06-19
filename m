From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:51:18 +0100
Subject: [PATCHv3 18/19] arm64: convert compat wrappers to C
In-Reply-To: <20180618120310.39527-19-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-19-mark.rutland@arm.com>
Message-ID: <20180619155117.hb5gfo654q2htzcy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:09PM +0100, Mark Rutland wrote:
> In preparation for converting to pt_regs syscall wrappers, convert our
> existing compat wrappers to C. This will allow the pt_regs wrappers to
> be automatically generated, and will allow for the compat register
> manipulation to be folded in with the pt_regs accesses.
> 
> To avoid confusion with the upcoming pt_regs wrappers and existing
> compat wrappers provided by core code, the C wrappers are renamed to
> compat_sys_aarch32_<syscall>.
> 
> With the assembly wrappers gone, we can get rid of entry32.S and the
> associated boilerplate.
> 
> Note that these must call the ksys_* syscall entry points, as the usual
> sys_* entry points will be modified to take a single pt_regs pointer
> argument.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
