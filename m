From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 31 Mar 2011 15:24:30 -0400
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <1301587083.31087.1032.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
Message-ID: <20110331192429.GD14441@home.goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 08:58:03AM -0700, Dave Hansen wrote:
> On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> > 
> > +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned long end,
> > +                                      gfp_t flag)
> > +{
> > +       unsigned long pfn = start, count;
> > +       struct page *page;
> > +       struct zone *zone;
> > +       int order;
> > +
> > +       VM_BUG_ON(!pfn_valid(start));
> 
> This seems kinda mean.  Could we return an error?  I understand that
> this is largely going to be an early-boot thing, but surely trying to
> punt on crappy input beats a full-on BUG().
> 
> 	if (!pfn_valid(start))
> 		return -1;

But still keep the warning?

	if (WARN_ON(!pfn_valid(start))
		return -1;

-- Steve
