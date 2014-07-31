From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 16:48:03 +0100
Subject: [PATCH 0/4] LLVMLinux: Patches to enable the kernel to be
 compiled with clang/LLVM
In-Reply-To: <CAOesGMiCiGwuGdOePPvE5WhZLRnG6qRvoJmBQHV4P9602Gy5DA@mail.gmail.com>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
 <20140731103323.GL26853@arm.com>
 <CAOesGMiCiGwuGdOePPvE5WhZLRnG6qRvoJmBQHV4P9602Gy5DA@mail.gmail.com>
Message-ID: <20140731154803.GB26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 04:39:55PM +0100, Olof Johansson wrote:
> On Thu, Jul 31, 2014 at 3:33 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jul 31, 2014 at 12:57:25AM +0100, behanw at converseincode.com wrote:
> >> From: Behan Webster <behanw@converseincode.com>
> >>
> >> This patch set moves from using locally defined named registers to access the
> >> stack pointer to using a globally defined named register. This allows the code
> >> to work both with gcc and clang.
> >>
> >> The LLVMLinux project aims to fully build the Linux kernel using both gcc and
> >> clang (the C front end for the LLVM compiler infrastructure project).
> >>
> >> Behan Webster (4):
> >>   arm64: LLVMLinux: Add current_stack_pointer() for arm64
> >>   arm64: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
> >>   arm64: LLVMLinux: Calculate current_thread_info from
> >>     current_stack_pointer
> >>   arm64: LLVMLinux: Use current_stack_pointer in kernel/traps.c
> >
> > Once Andreas's comments have been addressed:
> >
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > Please can you send a new series after the merge window?
> 
> Given that the ARM64 KVM guys are still actively breaking -next, and
> this is considerably smaller and lower risk than that, I think you can
> take it for 3.17?

Hey, those breakages are in the kvm tree not the arm64 tree! I'd really
rather wait on these as I don't see the rush to get them in for 3.17 and
it's not beyond the realms of possibility that they could cause problems
for a particular version of GCC (at the very least, I'd need to re-run
all the testing I've been doing).

Will
