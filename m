From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 15:49:13 +0000
Subject: When does mach-types get updated in a tree?
In-Reply-To: <d2617607-dfa2-4f72-9a42-4345b4a43307@VA3EHSMHS027.ehs.local>
References: <a9937fcf-a4cb-41c5-a767-ecfebae5c748@VA3EHSMHS024.ehs.local>
	<20110228101030.GB29843@n2100.arm.linux.org.uk>
	<0812376c-ea4b-4185-aa6e-6fb582dce21f@VA3EHSMHS032.ehs.local>
	<20110228151100.GB1937@n2100.arm.linux.org.uk>
	<d2617607-dfa2-4f72-9a42-4345b4a43307@VA3EHSMHS027.ehs.local>
Message-ID: <20110228154913.GC1937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 08:34:38AM -0700, John Linn wrote:
> > I do think we're heading for a major problem with the mach-types file
> > becoming too big inspite of its brevity.  I think I may start marking
> > entries as 'inactive' and therefore omitted from the kernel's tree if
> > they don't appear in mainline within one year of being allocated (or
> > some similar rule.)
> > 
> 
> Wouldn't device tree help with this problem?

We'll just end up with a string-space problem instead of a number space
problem.

I don't know how many clashing names we end up with today (because the
machine number allocator explicitly prevents it happening) but I would
not be surprised if there weren't clashes occuring with 3500 names
registered.

Having now done some investigations, this is silly.  About 86% of the
entries in the machine registry are not merged into the kernel.  48%
of the contents of the machine registry refer to platforms registered
more than two years ago but are not merged into mainline.  For four
years, that figure drops to 27%.  For one year, it's 64%.

So, merely implmenting a rule which says that entries which haven't
been merged into mainline within 12 months from the date they were last
updated would cut the file down to about 48K, almost 90K smaller.  I
think that's worth doing.
