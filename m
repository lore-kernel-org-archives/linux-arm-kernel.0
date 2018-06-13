From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 05:55:46 -0700
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
In-Reply-To: <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
Message-ID: <20180613125546.GB32016@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
> It is not only the matter of the spinlocks. GFP_ATOMIC is not supported 
> by the
> memory compaction code, which is used in alloc_contig_range(). Right, this
> should be also noted in the documentation.

Documentation is good, asserts are better.  The code should reject any
flag not explicitly supported, or even better have its own flags type
with the few actually supported flags.
