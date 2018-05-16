From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 16 May 2018 04:28:13 -0700
Subject: [PATCH 14/14] mm: turn on vm_fault_t type checking
In-Reply-To: <20180516054348.15950-15-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-15-hch@lst.de>
Message-ID: <20180516112813.GC20670@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 07:43:48AM +0200, Christoph Hellwig wrote:
> Switch vm_fault_t to point to an unsigned int with __b?twise annotations.
> This both catches any old ->fault or ->page_mkwrite instance with plain
> compiler type checking, as well as finding more intricate problems with
> sparse.

Come on, Christoph; you know better than this.  This patch is completely
unreviewable.  Split it into one patch per maintainer tree, and in any
event, the patch to convert vm_fault_t to an unsigned int should be
separated from all the trivial conversions.
