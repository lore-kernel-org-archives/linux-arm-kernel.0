From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 19 Oct 2018 09:45:12 -0400
Subject: [PATCH 03/10] swiotlb: do not panic on mapping failures
In-Reply-To: <20181019060425.GA28108@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-4-hch@lst.de>
 <20181019001714.GD1251@char.us.oracle.com>
 <20181019060425.GA28108@lst.de>
Message-ID: <20181019134512.GD54336@Konrads-MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 08:04:25AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:17:14PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Oct 08, 2018 at 10:02:39AM +0200, Christoph Hellwig wrote:
> > > All properly written drivers now have error handling in the
> > > dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> > > prints a useful warning when running out of swiotlb pool swace we can
> > 
> > s/swace/space/
> > 
> > > also remove swiotlb_full entirely as it serves no purpose now.
> > 
> > The panic albeit was useful for those drivers that didn't handle it.
> > 
> > Thoughts? I am kind of thinking screw them but then I am not too thrilled
> > about silent data corruption errors.
> 
> I can add an (optional) panic back in common code so that the different
> mapping types are covered.

Thank you.
> 
> Btw, are you fine with taking this through the dma mapping tree for
> this merge window?  I'd probably leave it in linux-next for another

Yes, please.
> week or so and don't send it with the first pull request on Monday.

<nods>
