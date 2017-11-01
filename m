From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 1 Nov 2017 13:16:44 +0000
Subject: [PATCH v5 01/30] regset: Add support for dynamically sized regsets
In-Reply-To: <20171101114228.jm53aj7jx6j4mxhn@armageddon.cambridge.arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <1509465082-30427-2-git-send-email-Dave.Martin@arm.com>
 <20171101114228.jm53aj7jx6j4mxhn@armageddon.cambridge.arm.com>
Message-ID: <20171101131644.GL19485@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 11:42:29AM +0000, Catalin Marinas wrote:
> On Tue, Oct 31, 2017 at 03:50:53PM +0000, Dave P Martin wrote:
> > Currently the regset API doesn't allow for the possibility that
> > regsets (or at least, the amount of meaningful data in a regset)
> > may change in size.
> > 
> > In particular, this results in useless padding being added to
> > coredumps if a regset's current size is smaller than its
> > theoretical maximum size.
> > 
> > This patch adds a get_size() function to struct user_regset.
> > Individual regset implementations can implement this function to
> > return the current size of the regset data.  A regset_size()
> > function is added to provide callers with an abstract interface for
> > determining the size of a regset without needing to know whether
> > the regset is dynamically sized or not.
> > 
> > The only affected user of this interface is the ELF coredump code:
> > This patch ports ELF coredump to dump regsets with their actual
> > size in the coredump.  This has no effect except for new regsets
> > that are dynamically sized and provide a get_size() implementation.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
> > Cc: H. J. Lu <hjl.tools@gmail.com>
> > 
> > ---
> > 
> > **Dropped** Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> > **Dropped** Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > (due to bug fix applied against v4 of this patch.)
> 
> It seems that the Reviewed-by tags are still there ;). Anyway, on the

Oops, looks like that only happened on this patch.  I've removed
Alex's R-b from my own version in case of repost -- can you also
do the same?

> new patch:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers
---Dave
