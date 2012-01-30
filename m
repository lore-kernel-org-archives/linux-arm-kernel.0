From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 30 Jan 2012 13:25:43 +0000
Subject: [PATCH 03/15] mm: compaction: introduce
 isolate_migratepages_range().
In-Reply-To: <op.v8wdlovn3l0zgt@mpn-glaptop>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-4-git-send-email-m.szyprowski@samsung.com>
 <20120130112428.GF25268@csn.ul.ie> <op.v8wdlovn3l0zgt@mpn-glaptop>
Message-ID: <20120130132543.GP25268@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 01:42:50PM +0100, Michal Nazarewicz wrote:
> >On Thu, Jan 26, 2012 at 10:00:45AM +0100, Marek Szyprowski wrote:
> >>From: Michal Nazarewicz <mina86@mina86.com>
> >>@@ -313,7 +316,7 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
> >> 		} else if (!locked)
> >> 			spin_lock_irq(&zone->lru_lock);
> >>
> >>-		if (!pfn_valid_within(low_pfn))
> >>+		if (!pfn_valid(low_pfn))
> >> 			continue;
> >> 		nr_scanned++;
> >>
> 
> On Mon, 30 Jan 2012 12:24:28 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> >This chunk looks unrelated to the rest of the patch.
> >
> >I think what you are doing is patching around a bug that CMA exposed
> >which is very similar to the bug report at
> >http://www.spinics.net/lists/linux-mm/msg29260.html . Is this true?
> >
> >If so, I posted a fix that only calls pfn_valid() when necessary. Can
> >you check if that works for you and if so, drop this hunk please? If
> >the patch does not work for you, then this hunk still needs to be
> >in a separate patch and handled separately as it would also be a fix
> >for -stable.
> 
> I'll actually never encountered this bug myself and CMA is unlikely to
> expose it, since it always operates on continuous memory regions with
> no holes.
> 
> I've made this change because looking at the code it seemed like this
> may cause problems in some cases.  The crash that you linked to looks
> like the kind of problem I was thinking about.
> 
> I'll drop this hunk and let you resolve this independently of CMA.
> 

Ok, thanks.

-- 
Mel Gorman
SUSE Labs
