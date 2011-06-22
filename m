From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 22 Jun 2011 18:04:39 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106221539.24044.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106221442.20848.arnd@arndb.de>
	<003701cc30de$7a159710$6e40c530$%szyprowski@samsung.com>
	<201106221539.24044.arnd@arndb.de>
Message-ID: <op.vxhix1zu3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jun 2011 15:39:23 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> Why that? I would expect you can do the same that hugepages (used to) do
> and just attempt high-order allocations. If they succeed, you can add  
> them as a CMA region and free them again, into the movable set of pages,  
> otherwise you just fail the  request from user space when the memory is
> already fragmented.

Problem with that is that CMA needs to have whole pageblocks allocated
and buddy can allocate at most half a pageblock.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
