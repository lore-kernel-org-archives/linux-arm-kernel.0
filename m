From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Mon, 14 May 2018 22:57:44 +0200
Subject: [PATCH 18/18] arm64: implement syscall wrappers
In-Reply-To: <20180514094640.27569-19-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-19-mark.rutland@arm.com>
Message-ID: <20180514205744.GC26773@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:46:40AM +0100, Mark Rutland wrote:
> Note that we play games with sys_ni_syscall(). It can't be defined with
> SYSCALL_DEFINE0() because we must avoid the possibility of error
> injection. Additionally, there are a couple of locations where we need
> to call it from C code, and we don't (currently) have a
> ksys_ni_syscall().  While it has no wrapper, passing in a redundant
> pt_regs pointer is benign per the AAPCS.
> 
> When ARCH_HAS_SYSCALL_WRAPPER is selected, no prototype is define for
> sys_ni_syscall(). Since we need to treat it differently for in-kernel
> calls and the syscall tables, the prototype is defined as-required.

> Largely the wrappers are largely the same as their x86 counterparts, but

That's one "Largely" too much.

> simplified as we don't have a variety of compat calling conventions that
> require separate stubs. Unlike x86, we have some zero-argument compat
> syscalls, and must define COMPAT_SYSCALL_DEFINE0().

... for consistent naming, or is there another reason for that?

This patch looks good in any case.

Thanks,
	Dominik
