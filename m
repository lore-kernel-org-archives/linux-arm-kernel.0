From: hch@lst.de (Christoph Hellwig)
Date: Mon, 27 Jul 2015 07:12:58 +0200
Subject: [PATCH v2 08/25] arch: introduce memremap()
In-Reply-To: <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726172527.GA29513@lst.de>
 <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
Message-ID: <20150727051258.GB15836@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 10:49:39AM -0700, Dan Williams wrote:
> On Sun, Jul 26, 2015 at 10:25 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Fri, Jul 24, 2015 at 10:38:42PM -0400, Dan Williams wrote:
> >> The behavior change to return NULL on an unsupported request is reserved
> >> for a later patch.
> >
> > Why?
> 
> This is for drivers like pmem that care about the mapping type.  For
> example, if pmem can't get a cache-enabled mapping it is potentially
> putting the write durability of the persistent media at risk.

I understand that part, but the question is why the old behavior
is retained for now and only changed later.
