From: hch@lst.de (Christoph Hellwig)
Date: Mon,  8 Oct 2018 10:02:36 +0200
Subject: move swiotlb noncoherent dma support from arm64 to generic code V2
Message-ID: <20181008080246.20543-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series starts with various swiotlb cleanups, then adds support for
non-cache coherent devices to the generic swiotlb support, and finally
switches arm64 to use the generic code.

Given that this series depends on patches in the dma-mapping tree, or
pending for it I've also published a git tree here:

    git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-noncoherent.2

Changes since v1:
 - make sure arm64 always calls dma_direct_alloc_pages to avoid
   circular calling conventions
 - add a patch in to stop dipping into the swiotlb pool for coherent
   allocations - this just depletes the swiotlb pool for no good reason
