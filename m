From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 23:20:27 +0100
Subject: [PATCH 1/5] arm: LLVMLinux: Add current_stack_pointer macro
 for ARM
In-Reply-To: <1378502899-1241-2-git-send-email-behanw@converseincode.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-2-git-send-email-behanw@converseincode.com>
Message-ID: <20130906222027.GR6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 05:28:07PM -0400, behanw at converseincode.com wrote:
> From: Behan Webster <behanw@converseincode.com>
> 
> A macro to get the current stack pointer which allows for a single place in
> which to do so with ASM. Before this named registers (a gcc extension) was used
> to get the stack pointer. Using ASM is a more portable way of getting the stack
> pointer which works with both gcc and clang.  This macro is of the same name
> used in the X86 arch.

This will result in less optimal code - rather than the compiler being
able to mask directly with 'sp', it's going to have to use this bit of
assembly to first move it into another register.

Why do we want this change?
