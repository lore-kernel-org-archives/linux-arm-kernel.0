From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 01 Nov 2011 19:06:56 +0100
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <20111101150448.GD14998@csn.ul.ie>
References: <20111018122109.GB6660@csn.ul.ie>
	<809d0a2afe624c06505e0df51e7657f66aaf9007.1319428526.git.mina86@mina86.com>
	<20111101150448.GD14998@csn.ul.ie>
Message-ID: <op.v394luhl3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Nov 2011 16:04:48 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> For the purposes of review, have a separate patch for moving
> isolate_freepages_block to another file that does not alter the
> function in any way. When the function is updated in a follow-on patch,
> it'll be far easier to see what has changed.

Will do.

> page_isolation.c may also be a better fit than page_alloc.c

Since isolate_freepages_block() is the only user of split_free_page(),
would it make sense to move split_free_page() to page_isolation.c as
well?  I sort of like the idea of making it static and removing from
header file.

> I confess I didn't read closely because of the mess in page_alloc.c but
> the intent seems fine.

No worries.  I just needed for a quick comment whether I'm headed the right
direction. :)

> Hopefully there will be a new version of CMA posted that will be easier
> to review.

I'll try and create the code no latter then on the weekend so hopefully
the new version will be sent next week.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
