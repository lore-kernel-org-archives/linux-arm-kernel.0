From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 15:26:51 -0700
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.vs8awkrx3l0zgt@mnazarewicz-glaptop>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<op.vs77qfx03l0zgt@mnazarewicz-glaptop>
	<1301606078.31087.1275.camel@nimitz>
	<op.vs8awkrx3l0zgt@mnazarewicz-glaptop>
Message-ID: <1301610411.30870.29.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-01 at 00:18 +0200, Michal Nazarewicz wrote:
> On Thu, 31 Mar 2011 23:14:38 +0200, Dave Hansen wrote:
> > We BUG_ON() in bootmem.  Basically if we try to allocate an early-boot
> > structure and fail, we're screwed.  We can't keep running without an
> > inode hash, or a mem_map[].
> >
> > This looks like it's going to at least get partially used in drivers, at
> > least from the examples.  Are these kinds of things that, if the driver
> > fails to load, that the system is useless and hosed?  Or, is it
> > something where we might limp along to figure out what went wrong before
> > we reboot?
> 
> Bug in the above place does not mean that we could not allocate memory.  It
> means caller is broken.

Could you explain that a bit?

Is this a case where a device is mapped to a very *specific* range of
physical memory and no where else?  What are the reasons for not marking
it off limits at boot?  I also saw some bits of isolation and migration
in those patches.  Can't the migration fail?  

-- Dave
