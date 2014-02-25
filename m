From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 18:30:12 +0000
Subject: [PATCH v4 0/6] generic early_ioremap support
In-Reply-To: <1393337404.7307.51.camel@deneb.redhat.com>
References: <1392238575-10000-1-git-send-email-msalter@redhat.com>
 <1393337404.7307.51.camel@deneb.redhat.com>
Message-ID: <20140225183012.GA27164@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 02:10:04PM +0000, Mark Salter wrote:
> On Wed, 2014-02-12 at 15:56 -0500, Mark Salter wrote:
> > This patch series takes the common bits from the x86 early ioremap
> > implementation and creates a generic implementation which may be used
> > by other architectures. The early ioremap interfaces are intended for
> > situations where boot code needs to make temporary virtual mappings
> > before the normal ioremap interfaces are available. Typically, this
> > means before paging_init() has run.
> > 
> > These patches are layered on top of generic fixmap patches which
> > were pulled into 3.14-rc with the exception of the arm patch:
> > 
> >   https://lkml.org/lkml/2013/11/25/477
> > 
> > The arm fixmap patch is currently in the akpm tree and has been
> > part of linux-next for a while.
> > 
> > This is version 4 of the patch series. These patches (and underlying
> > fixmap patches) may be found at:
> > 
> >   git://github.com/mosalter/linux.git (early-ioremap-v4 branch)
> 
> There have been no comments on this patch series over the past
> two weeks. I'd like to get it into linux-next for some wider
> testing and eventually into 3.15. Is there something I can do
> to help it along?

I'd suggest spitting the core part out from the arch-specific parts. That
way, the core part can merged independently and architectures can move over
as they see fit. It also signals (at least to me) that, "hey, I should
probably review this" whilst my current stance is "there's a whole load of
stuff under mm/ that needs to be acked first".

If you put the whole thing into next, you just run the risk of conflicts
with all the arch trees.

Will
