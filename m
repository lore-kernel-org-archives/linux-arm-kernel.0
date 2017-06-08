From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:25:25 +0200
Subject: clean up and modularize arch dma_mapping interface
Message-ID: <20170608132609.32662-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

Btw, we don't seem to have a tree every-growing amount of common dma
mapping code, and given that I have a fair amount of all over the tree
work in that area in my plate I'd like to start one.  Any good reason
to that?  Anyone willing to volunteer as co maintainer?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
