From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Oct 2014 12:13:00 +0000
Subject: [PATCH 01/10] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <20141024092451.GA24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <f57759dbc105dd3996acd959d4e3157224ff81fa.1414099246.git.geoff@infradead.org>
 <20141024092451.GA24265@leverpostej>
Message-ID: <20141027121300.GR8768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 10:24:51AM +0100, Mark Rutland wrote:
> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > Some of the macros defined in kvm_arm.h are useful in assembly files, but are
> > not compatible with the assembler.  Change any C language integer constant
> > definitions using appended U, UL, or ULL to the UL() preprocessor macro.  Also,
> > add a preprocessor include of the asm/memory.h file which defines the UL()
> > macro.
> > 
> > Fixes build errors like these when using kvm_arm.h in assembly
> > source files:
> > 
> >   Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> 
> Thanks for putting this together, Geoff.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

This doesn't apply against -rc2 (see below). If you send a rebased version
of this patch, I'm happy to queue it for 3.19.

Alternatively, it could go via the kvm tree. Christoffer, Marc, do you have
a preference? (the kexec stuff depends on this, so that's why I was thinking
of queuing it in the arm64 tree).

Thanks,

Will

--->8

Applying: arm64/kvm: Fix assembler compatibility of macros
error: patch failed: arch/arm64/include/asm/kvm_arm.h:149
error: arch/arm64/include/asm/kvm_arm.h: patch does not apply
Patch failed at 0001 arm64/kvm: Fix assembler compatibility of macros
The copy of the patch that failed is found in:
   /home/will/work/aarch32/linux/linux/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
