From: hch@lst.de (Christoph Hellwig)
Date: Wed, 29 Jul 2015 08:50:04 +0200
Subject: [PATCH v2 08/25] arch: introduce memremap()
In-Reply-To: <CAPcyv4jN6jYzw11qOOR-xd_w6s5dguQSoHyvmPFSWtL9S+tz3w@mail.gmail.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726172527.GA29513@lst.de>
 <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
 <20150727051258.GB15836@lst.de>
 <CAPcyv4jN6jYzw11qOOR-xd_w6s5dguQSoHyvmPFSWtL9S+tz3w@mail.gmail.com>
Message-ID: <20150729065004.GA17162@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 04:26:03PM -0700, Dan Williams wrote:
> Oh, because all we have at this point is ioremap_cache() which
> silently falls back.  It's not until the introduction of
> arch_memremp() where we update the arch code to break that behavior.

Ok, makes sense.  Might be worth to document in the changelog.

> That said, I think it may be beneficial to allow a fallback if the
> user cares.  So maybe memremap() can call plain ioremap() if
> MEMREMAP_STRICT is not set and none of the other mapping types are
> satisfied.

Is there a real use case for it?  Fallback APIs always seem confusing
and it might make more sense to do this in the caller(s) that actually
need it.
