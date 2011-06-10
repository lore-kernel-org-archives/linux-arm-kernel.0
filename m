From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Jun 2011 14:22:05 +0200
Subject: [PATCH 02/10] lib: genalloc: Generic allocator improvements
In-Reply-To: <20110610122451.15af86d1@lxorguk.ukuu.org.uk>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<1307699698-29369-3-git-send-email-m.szyprowski@samsung.com>
	<20110610122451.15af86d1@lxorguk.ukuu.org.uk>
Message-ID: <000c01cc2769$02669b70$0733d250$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 10, 2011 1:25 PM Alan Cox wrote:

> I am curious about one thing
> 
> Why do we need this allocator. Why not use allocate_resource and friends.
> The kernel generic resource handler already handles object alignment and
> subranges. It just seems to be a surplus allocator that could perhaps be
> mostly removed by using the kernel resource allocator we already have ?

genalloc was used mainly for historical reasons (in the earlier version we
were looking for direct replacement for first fit allocator).

I plan to replace it with lib/bitmap.c bitmap_* based allocator (similar like
it it is used by dma_declare_coherent_memory() and friends in
drivers/base/dma-coherent.c). We need something really simple for CMA area
management. 

IMHO allocate_resource and friends a bit too heavy here, but good to know 
that such allocator also exists.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
