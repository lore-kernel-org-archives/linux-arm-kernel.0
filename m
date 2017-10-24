From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Oct 2017 15:48:10 +0100
Subject: [PATCH v3 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171019165332.GD30652@arm.com>
References: <1507810851-306-1-git-send-email-will.deacon@arm.com>
 <20171019165332.GD30652@arm.com>
Message-ID: <20171024144810.GD14568@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ingo, Peter,

Would you be willing to merge this via -tip, please? I'm happy to
rebase/repost as required, but the code is in good shape now.

Will

On Thu, Oct 19, 2017 at 05:53:32PM +0100, Will Deacon wrote:
> On Thu, Oct 12, 2017 at 01:20:46PM +0100, Will Deacon wrote:
> > This is version three of the patches previously posted here:
> > 
> > v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
> > v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534981.html
> > 
> > Changes since v2 include:
> > 
> >   * Drop unused cnt argument
> >   * Fix typo in UNLOCK Kconfig inlining options
> >   * Added Tested-by tags
> > 
> > Thanks to all of those who provided review and testing feedback!
> 
> I've not had any more feedback on this and the testing results are very
> encouraging so I'd like to merge it for 4.15. However, it might make more
> sense for the whole thing to go via -tip instead.
> 
> Ingo, Peter: what do you prefer?
> 
> Will
> 
> > Will Deacon (5):
> >   kernel/locking: Use struct qrwlock instead of struct __qrwlock
> >   locking/atomic: Add atomic_cond_read_acquire
> >   kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
> >   arm64: locking: Move rwlock implementation over to qrwlocks
> >   kernel/locking: Prevent slowpath writers getting held up by fastpath
> > 
> >  arch/arm64/Kconfig                      |  17 ++++
> >  arch/arm64/include/asm/Kbuild           |   1 +
> >  arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
> >  arch/arm64/include/asm/spinlock_types.h |   6 +-
> >  include/asm-generic/atomic-long.h       |   3 +
> >  include/asm-generic/qrwlock.h           |  37 ++-----
> >  include/asm-generic/qrwlock_types.h     |  15 ++-
> >  include/linux/atomic.h                  |   4 +
> >  kernel/locking/qrwlock.c                |  86 +++--------------
> >  9 files changed, 61 insertions(+), 272 deletions(-)
> > 
> > -- 
> > 2.1.4
> > 
