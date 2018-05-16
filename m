From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 15:03:44 +0200
Subject: [PATCH 14/14] mm: turn on vm_fault_t type checking
In-Reply-To: <20180516112813.GC20670@bombadil.infradead.org>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-15-hch@lst.de>
 <20180516112813.GC20670@bombadil.infradead.org>
Message-ID: <20180516130344.GC32454@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 04:28:13AM -0700, Matthew Wilcox wrote:
> On Wed, May 16, 2018 at 07:43:48AM +0200, Christoph Hellwig wrote:
> > Switch vm_fault_t to point to an unsigned int with __b?twise annotations.
> > This both catches any old ->fault or ->page_mkwrite instance with plain
> > compiler type checking, as well as finding more intricate problems with
> > sparse.
> 
> Come on, Christoph; you know better than this.  This patch is completely
> unreviewable.  Split it into one patch per maintainer tree, and in any
> event, the patch to convert vm_fault_t to an unsigned int should be
> separated from all the trivial conversions.

The whole point is that tiny split patches for mechnical translations
are totally pointless.  Switching the typedef might be worth splitting
if people really insist.
