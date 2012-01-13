From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 13 Jan 2012 21:04:31 +0100
Subject: [PATCH 04/11] mm: page_alloc: introduce alloc_contig_range()
In-Reply-To: <20120110141613.GB3910@csn.ul.ie>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-5-git-send-email-m.szyprowski@samsung.com>
 <20120110141613.GB3910@csn.ul.ie>
Message-ID: <op.v71gpt1b3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Dec 29, 2011 at 01:39:05PM +0100, Marek Szyprowski wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> +	/* Make sure all pages are isolated. */
>> +	if (!ret) {
>> +		lru_add_drain_all();
>> +		drain_all_pages();
>> +		if (WARN_ON(test_pages_isolated(start, end)))
>> +			ret = -EBUSY;
>> +	}

On Tue, 10 Jan 2012 15:16:13 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> Another global IPI seems overkill. Drain pages only from the local CPU
> (drain_pages(get_cpu()); put_cpu()) and test if the pages are isolated.

Is get_cpu() + put_cpu() required? Won't drain_local_pages() work?

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
