From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Mar 2016 09:51:43 -0700
Subject: [PATCH v2 4/7] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160330165143.GI2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 05:39:51PM +0200, Boris Brezillon wrote:
> sg_alloc_table_from_buf() provides an easy solution to create an sg_table
> from a virtual address pointer. This function takes care of dealing with
> vmallocated buffers, buffer alignment, or DMA engine limitations (maximum
> DMA transfer size).

This seems nice.  Should we also have a further helper on top of this
which will get constraints from a dmaengine, it seems like it'd be a
common need?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/6feb33d1/attachment-0001.sig>
