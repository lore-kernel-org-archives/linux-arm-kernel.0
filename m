From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Dec 2013 11:33:48 +0000
Subject: [PATCH 1/2] ARM: check stack pointer in get_wchan
In-Reply-To: <20131205083424.32632.51618.stgit@buzz>
References: <20131205083424.32632.51618.stgit@buzz>
Message-ID: <20131205113348.GE4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 12:34:24PM +0400, Konstantin Khlebnikov wrote:
> get_wchan() is lockless. Task may wakeup at any time and change its own stack,
> thus each next stack frame may be overwritten and filled with random stuff.
> 
> /proc/$pid/stack interface had been disabled for non-current tasks, see [1]
> But 'wchan' still allows to trigger stack frame unwinding on volatile stack.
> 
> This patch fixes oops in unwind_frame() by adding stack pointer validation on
> each step (as x86 code do), unwind_frame() already checks frame pointer.
> 
> Also I've found another report of this oops on stackoverflow (irony).

Your two patches look fine to me.  Please put them in the patch system
and we'll get them merged - I think they should also be merged into stable
trees too - it looks like this goes all the way back to 2.6.30 kernels.

Thanks.
