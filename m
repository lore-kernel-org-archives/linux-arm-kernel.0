From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 10 Jun 2011 13:52:17 +0100
Subject: [PATCH 02/10] lib: genalloc: Generic allocator improvements
In-Reply-To: <000c01cc2769$02669b70$0733d250$%szyprowski@samsung.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<1307699698-29369-3-git-send-email-m.szyprowski@samsung.com>
	<20110610122451.15af86d1@lxorguk.ukuu.org.uk>
	<000c01cc2769$02669b70$0733d250$%szyprowski@samsung.com>
Message-ID: <20110610135217.701a2fd2@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I plan to replace it with lib/bitmap.c bitmap_* based allocator (similar like
> it it is used by dma_declare_coherent_memory() and friends in
> drivers/base/dma-coherent.c). We need something really simple for CMA area
> management. 
> 
> IMHO allocate_resource and friends a bit too heavy here, but good to know 
> that such allocator also exists.

Not sure I'd class allocate_resource as heavyweight but providing it's
using something that already exists rather than inventing yet another
allocator.

This wants dealing with before it goes upstream though so the chaneges in
lib/*c etc never have to reach mainline and then get changed back.

Alan
