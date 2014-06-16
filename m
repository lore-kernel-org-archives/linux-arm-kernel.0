From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 17:45:17 +0100
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <5537408.I9tiuCA96J@wuerfel>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <20140606110652.GB4116@e103592.cambridge.arm.com>
 <20140616162653.GV16758@arm.com> <5537408.I9tiuCA96J@wuerfel>
Message-ID: <20140616164517.GY16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 05:42:10PM +0100, Arnd Bergmann wrote:
> On Monday 16 June 2014 17:26:53 Will Deacon wrote:
> > On Fri, Jun 06, 2014 at 12:07:11PM +0100, Dave Martin wrote:
> > > On Fri, Jun 06, 2014 at 08:48:26AM +0200, Arnd Bergmann wrote:
> > > > On Thursday 05 June 2014 21:37:09 Zhen Lei wrote:
> > > > 
> > > > > +- smmu-masters  : A list of phandles to device nodes representing bus
> > > > > +                  masters for which the SMMU can provide a translation
> > > > > +                  and their corresponding StreamIDs (see example below).
> > > > > 
> > > > 
> > > > We're currently in the process of defining a generic binding for IOMMUs.
> > > > 
> > > > While the smmu-masters property was copied from an existing binding,
> > > > I think we will end up migrating away from that towards a common way
> > > > to express those things, and we shouldn't add another one doing this
> > > > in a nonstandard way. Please have a look at the latest discussion
> > > > about the iommu binding using #iommu-cells and a reference from the
> > > > master to the iommu and see if you can migrate your code to use that.
> > > 
> > > Thanks for making this point -- I was going to do so yesterday but then
> > > hesitated due to uncertainty about whether this should really be a new
> > > driver.
> > > 
> > > Either way, it would be very valuable at least to attempt to describe
> > > the Hisilicon SMMU implemenation using the new proposals, since that is
> > > a good test of how reusable the proposed generic binding actually is.
> > 
> > If this ends up being an addition to the existing ARM SMMU driver, I'm
> > really not keen on using the new DT bindings. We're already stuck with
> > the old bindings for that driver -- supporting both old and new in the
> > same code only buys us maintenance headaches and pointless divergence
> > within the driver.
> 
> We have to migrate the driver to the new binding anyway, it may be
> a bit painful, but there are not really any users yet so there
> is a chance we can remove the nonstandard code at some point,
> perhaps in a few years.

The only way I see this working is if we kill the existing binding and move
exclusively to the new one. I'm actually ok with that (we have no in-tree
users), but it needs to happen ASAP in my opinion, otherwise we increase the
window where the old binding can be adopted.

Note that the next version of the ARM SMMU (v3) is considerably different to
the current architecture, so a new driver (using the new bindings) will be
required.

This actually opens a wider question: if we don't have an in-tree user for a
device-tree binding, do we consider that binding to be unused?

Will
