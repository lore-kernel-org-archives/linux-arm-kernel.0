From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 12:40:08 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <8928ec99-5f5b-905b-5922-81a009f18999@suse.de>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <8928ec99-5f5b-905b-5922-81a009f18999@suse.de>
Message-ID: <20170302124008.GE19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 12:54:24PM +0100, Andreas F?rber wrote:
> Hi Mark,
> 
> Am 03.01.2017 um 19:27 schrieb Mark Rutland:
> > Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
> > inverted the relationship between get_current() and
> > current_thread_info(), with sp_el0 now holding the current task_struct
> > rather than the current thead_info. The new implementation of
> 
> "thread_info"?

struct thread_info, as returned by current_thread_info().

> > get_current() prevents the compiler from being able to optimize repeated
> > calls to either, resulting in a noticeable penalty in some
> > microbenchmarks.
> > 
> > This patch restores the previous optimisation by implementing
> > get_current() in the same way as our old current_thread_info(), using a
> > non-volatile asm statement.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: Davidlohr Bueso <dbueso@suse.de>
> 
> Should this get a Fixes: c02433dd6de32f04 ("arm64: split thread_info
> from task stack") header?

Both c02433dd6de32f04 and this patch are already in mainline.

Thanks,
Mark.
