From: hch@lst.de (Christoph Hellwig)
Date: Thu, 11 Jun 2015 09:31:07 +0200
Subject: [PATCH 2/2] scatterlist: cleanup sg_chain() and sg_unmark_end()
In-Reply-To: <20150610053803.GA1693@gondor.apana.org.au>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162715.21910.77696.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610053803.GA1693@gondor.apana.org.au>
Message-ID: <20150611073107.GD1905@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 01:38:04PM +0800, Herbert Xu wrote:
> On Tue, Jun 09, 2015 at 12:27:15PM -0400, Dan Williams wrote:
> >
> > +#define scatterwalk_sg_chain(prv, num, sgl)	sg_chain(prv, num, sgl)
> > +#define scatterwalk_sg_next(sgl)		sg_next(sgl)
> 
> Why are you reintroducing the scatterwalk_sg_next macro that we
> just removed?
> 
> I also don't understand why this is so urgent that it has to go
> into mainline at this late date.

It allows getting a cleaner slate for the next merge window, which seems
useful on it's own.  The re-addition of scatterwalk_sg_next seems next,
but getting rid of the open-coded sg_chain is useful.

Maybe you can take it through the crypto tree and also kill off the
scatterwalk_sg_chain name as well while we're at it?
