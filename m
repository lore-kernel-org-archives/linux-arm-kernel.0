From: msalter@redhat.com (Mark Salter)
Date: Tue, 11 Mar 2014 09:20:16 -0400
Subject: [PATCH v6 0/6] mm: generic early_ioremap support
In-Reply-To: <20140311120845.GG31104@arm.com>
References: <1394384444-23182-1-git-send-email-msalter@redhat.com>
 <20140311120845.GG31104@arm.com>
Message-ID: <1394544016.5094.68.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-11 at 12:08 +0000, Catalin Marinas wrote:
> Mark,
> 
> On Sun, Mar 09, 2014 at 05:00:38PM +0000, Mark Salter wrote:
> > This patch series takes the common bits from the x86 early ioremap
> > implementation and creates a generic implementation which may be used
> > by other architectures. The early ioremap interfaces are intended for
> > situations where boot code needs to make temporary virtual mappings
> > before the normal ioremap interfaces are available. Typically, this
> > means before paging_init() has run.
> > 
> > These patches are layered on top of generic fixmap patches which
> > were pulled into upstream 3.14-rc kernels.
> > 
> > This is version 6 of the patch series. These patches fixmap patches
> > may be found at:
> > 
> >   git://github.com/mosalter/linux.git (early-ioremap-v6 branch)
> 
> Are there any acks still needed? I think the arch patches in this series
> have been acked, so I'm happy if hpa or someone else takes the whole
> series.

v6 added a documentation patch which is the only one without an ack.
I was going to give it a few days and then send a pull request
tomorrow (12-Mar). This being mm related, I thought the mmotm tree
may be the place for it, but hpa offered the tip tree and it really
doesn't matter to me which one it goes through.
