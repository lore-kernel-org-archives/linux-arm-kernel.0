From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 6 Oct 2017 11:10:14 +0000
Subject: [PATCH v10 09/10] mm: stop zeroing memory during allocation in
 vmemmap
In-Reply-To: <20171005211124.26524-10-pasha.tatashin@oracle.com>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
 <20171005211124.26524-10-pasha.tatashin@oracle.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008BA85@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Tatashin
> Sent: 05 October 2017 22:11
> vmemmap_alloc_block() will no longer zero the block, so zero memory
> at its call sites for everything except struct pages.  Struct page memory
> is zero'd by struct page initialization.

It seems dangerous to change an allocator to stop zeroing memory.
It is probably saver to add a new function that doesn't zero
the memory and use that is the places where you don't want it
to be zeroed.

	David
