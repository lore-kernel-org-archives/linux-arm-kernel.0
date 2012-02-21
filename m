From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 13:16:17 +0000
Subject: [PATCH - linux-next] ARM: ptrace: Fix audit caused compile error
In-Reply-To: <1329825855-11902-1-git-send-email-peter.ujfalusi@ti.com>
References: <1329825855-11902-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120221131616.GI19696@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 12:04:15PM +0000, Peter Ujfalusi wrote:
> While trying to compile the kernel for ARM (omap2plus_defconfig) the kernel
> build fails with:
> 
> arch/arm/kernel/ptrace.c: In function ?syscall_trace?:
> arch/arm/kernel/ptrace.c:920:3: error: implicit declaration of function ?audit_syscall_exit?
> arch/arm/kernel/ptrace.c:922:3: error: implicit declaration of function ?audit_syscall_entry?
> arch/arm/kernel/ptrace.c:922:23: error: ?AUDIT_ARCH_ARMEB? undeclared (first use in this function)
> arch/arm/kernel/ptrace.c:922:23: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/kernel/ptrace.o] Error 1
> 
> The issue created by commit:
> 29ef73b7 Kernel: Audit Support For The ARM Platform
> 
> We need to include the linux/audit.h header to the arch/arm/kernel/ptrace.c
> file to be able to compile the kernel.

This was already reported and I think Russell was going to revert the
offending commit, since it needed some rework to handle little-endian
configurations.

I can't see the revert in any of the trees I'm tracking though...

Will
