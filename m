From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2012 16:48:29 +0100
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <201201261531.40551.arnd@arndb.de>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
Message-ID: <009f01ccdc41$f30a5f70$d91f1e50$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, January 26, 2012 4:32 PM Arnd Bergmann wrote:

> On Thursday 26 January 2012, Marek Szyprowski wrote:
> > Welcome everyone!
> >
> > Yes, that's true. This is yet another release of the Contiguous Memory
> > Allocator patches. This version mainly includes code cleanups requested
> > by Mel Gorman and a few minor bug fixes.
> 
> Hi Marek,
> 
> Thanks for keeping up this work! I really hope it works out for the
> next merge window.
> 
> > TODO (optional):
> > - implement support for contiguous memory areas placed in HIGHMEM zone
> > - resolve issue with movable pages with pending io operations
> 
> Can you clarify these? I believe the contiguous memory areas in highmem
> is something that should really be after the existing code is merged
> into the upstream kernel and should better not be listed as TODO here.

Ok, I will remove it from the TODO list. Core memory management is very 
little dependence on HIGHMEM, it is more about DMA-mapping framework to 
be aware that there might be no lowmem mappings for the allocated pages.
This can be easily added once the initial version got merged.
 
> I haven't followed the last two releases so closely. It seems that
> in v17 the movable pages with pending i/o was still a major problem
> but in v18 you added a solution. Is that right? What is still left
> to be done here then?

Since v18 the failed allocation is retried in a bit different place in 
the contiguous memory area what heavily increased overall reliability.

This can be improved by making cma a bit more aware about pending io 
operations, but I want to leave this after the initial merge.

I think that there are no major issues left to be resolved now.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
