From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 12 Dec 2011 16:46:10 +0100
Subject: [PATCH 04/11] mm: compaction: export some of the functions
In-Reply-To: <20111212154015.GI3277@csn.ul.ie>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-5-git-send-email-m.szyprowski@samsung.com>
 <20111212142906.GE3277@csn.ul.ie> <op.v6dseqji3l0zgt@mpn-glaptop>
 <20111212154015.GI3277@csn.ul.ie>
Message-ID: <op.v6dve8mo3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Mon, 12 Dec 2011 15:29:07 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
>>> Overall, this patch implies that CMA is always compiled in.

> On Mon, Dec 12, 2011 at 03:41:04PM +0100, Michal Nazarewicz wrote:
>> Not really.  But yes, it produces some bloat when neither CMA nor
>> compaction are compiled.  I assume that linker will be able to deal
>> with that (since the functions are not EXPORT_SYMBOL'ed).

On Mon, 12 Dec 2011 16:40:15 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> The bloat exists either way. I don't believe the linker strips it out so
> overall it would make more sense to depend on compaction to keep the
> vmstat counters for debugging reasons if nothing else. It's not
> something I feel very strongly about though.

KK, I'll do that then.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
