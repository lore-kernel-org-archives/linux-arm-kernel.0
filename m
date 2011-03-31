From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 01 Apr 2011 00:18:10 +0200
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <1301606078.31087.1275.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<op.vs77qfx03l0zgt@mnazarewicz-glaptop>
	<1301606078.31087.1275.camel@nimitz>
Message-ID: <op.vs8awkrx3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
>> +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned
>> long end,
>> +                                      gfp_t flag)
>> +{
>> +       unsigned long pfn = start, count;
>> +       struct page *page;
>> +       struct zone *zone;
>> +       int order;
>> +
>> +       VM_BUG_ON(!pfn_valid(start));

On Thu, 31 Mar 2011 23:14:38 +0200, Dave Hansen wrote:
> We BUG_ON() in bootmem.  Basically if we try to allocate an early-boot
> structure and fail, we're screwed.  We can't keep running without an
> inode hash, or a mem_map[].
>
> This looks like it's going to at least get partially used in drivers, at
> least from the examples.  Are these kinds of things that, if the driver
> fails to load, that the system is useless and hosed?  Or, is it
> something where we might limp along to figure out what went wrong before
> we reboot?

Bug in the above place does not mean that we could not allocate memory.  It
means caller is broken.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
