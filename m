From: hch@lst.de (Christoph Hellwig)
Date: Mon, 27 Jul 2015 07:14:13 +0200
Subject: [PATCH v2 25/25] pmem: convert to generic memremap
In-Reply-To: <CAPcyv4jsnQ1CzgXkkpzJnfjnKMmxiwyhQ_3osgo9vmjceP+rZA@mail.gmail.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024020.8664.52581.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726173317.GD29513@lst.de>
 <CAPcyv4jsnQ1CzgXkkpzJnfjnKMmxiwyhQ_3osgo9vmjceP+rZA@mail.gmail.com>
Message-ID: <20150727051413.GC15836@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 11:11:44AM -0700, Dan Williams wrote:
> I don't follow.  We have __iomem for the cpu mapping of a resource and
> dma_map() for a PCI device.  __pmem works the same and is there to
> make sure someone doesn't simply de-reference a pointer to pmem and
> hope that the write is persistent.

But no deference of a kernel pointer is magily persistent, so I'm
not really worried about that.  It just means whenever we want to
pass it to anything we'll need to cast.  And anything that does
I/O falls into that category.
