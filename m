From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 2 Jul 2018 06:30:16 -0700
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
In-Reply-To: <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
 <20180613125546.GB32016@infradead.org>
 <20180613133913.GD20315@dhcp22.suse.cz>
 <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
Message-ID: <20180702133016.GA16909@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 03:23:34PM +0200, Marek Szyprowski wrote:
> What about clearing the allocated buffer? Should it be another bool 
> parameter,
> done unconditionally or moved to the callers?

Please keep it in the callers.  I plan to push it up even higher
from the current callers short to midterm.
