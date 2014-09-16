From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 17:07:59 +0100
Subject: [PATCH 1/8] arm: Convert pr_warning to pr_warn
In-Reply-To: <20140915155656.GA29744@arm.com>
References: <cover.1410632834.git.joe@perches.com>
 <7995478e8c658478cd37dabb996f7269405251ac.1410632835.git.joe@perches.com>
 <20140915155656.GA29744@arm.com>
Message-ID: <20140916160759.GJ12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 04:56:56PM +0100, Will Deacon wrote:
> On Sat, Sep 13, 2014 at 07:31:12PM +0100, Joe Perches wrote:
> > Use the more common pr_warn.
> > 
> > Other miscellanea:
> > 
> > o Coalesce formats
> > o Realign arguments
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  arch/arm/include/asm/syscall.h   |  8 ++++----
> >  arch/arm/kernel/atags_parse.c    |  2 +-
> >  arch/arm/kernel/hw_breakpoint.c  | 18 +++++++++---------
> >  arch/arm/kernel/irq.c            |  4 ++--
> >  arch/arm/kernel/perf_event_cpu.c |  4 ++--
> >  arch/arm/kernel/smp.c            |  2 +-
> >  arch/arm/kernel/unwind.c         | 24 ++++++++++++------------
> >  arch/arm/mm/idmap.c              |  2 +-
> >  arch/arm/mm/mmu.c                |  4 ++--
> >  9 files changed, 34 insertions(+), 34 deletions(-)
> 
> It's Russell's call on this, but it really looks like more trouble than it's
> worth imo. Having git blame identify the person who wrote the original code
> is considerably more useful than being pointed at somebody making cosmetic
> changes.

I have no objection to this patch set, but I'll echo Will's comment
that having git blame identify who wrote the code is useful.

However, removing old cruft is also a useful exercise, as it keeps
things simpler (because we're not carrying around lots of excess
baggage.)  So, I think on balance it's worth the churn.

Joe, any chance you could add a KernelVersion: tag somewhere in the
commit message and throw it at patches at arm.linux.org.uk so it doesn't
get lost?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
