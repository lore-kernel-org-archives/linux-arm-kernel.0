From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 20:18:31 +0200
Subject: [PATCH v2 4/7] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <20160330165143.GI2350@sirena.org.uk>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160330165143.GI2350@sirena.org.uk>
Message-ID: <20160330201831.38e1d6bd@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2016 09:51:43 -0700
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Mar 30, 2016 at 05:39:51PM +0200, Boris Brezillon wrote:
> > sg_alloc_table_from_buf() provides an easy solution to create an sg_table
> > from a virtual address pointer. This function takes care of dealing with
> > vmallocated buffers, buffer alignment, or DMA engine limitations (maximum
> > DMA transfer size).
> 
> This seems nice.  Should we also have a further helper on top of this
> which will get constraints from a dmaengine, it seems like it'd be a
> common need?

Yep, we could create a wrapper extracting dma_slave caps info,
converting it to sg_constraints and calling sg_alloc_table_from_buf().
But let's try to get this function accepted first, and I'll send another
patch providing this wrapper.

BTW, do you see other things that should be added in sg_constraints?

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
