From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jun 2014 18:44:41 +0200
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <8620067.9Lo76DOS52@wuerfel>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
 <8620067.9Lo76DOS52@wuerfel>
Message-ID: <4866660.vPM7eC1n99@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 June 2014 08:48:26 Arnd Bergmann wrote:
> On Thursday 05 June 2014 21:37:09 Zhen Lei wrote:
> 
> > +- smmu-masters  : A list of phandles to device nodes representing bus
> > +                  masters for which the SMMU can provide a translation
> > +                  and their corresponding StreamIDs (see example below).
> > 
> 
> We're currently in the process of defining a generic binding for IOMMUs.
> 
> While the smmu-masters property was copied from an existing binding,
> I think we will end up migrating away from that towards a common way
> to express those things, and we shouldn't add another one doing this
> in a nonstandard way. Please have a look at the latest discussion
> about the iommu binding using #iommu-cells and a reference from the
> master to the iommu and see if you can migrate your code to use that.

Actually, nothing in 3.16 uses the broken binding yet, so I think
we can just declare it obsolete and remove it once the new binding
has been implemented.

	Arnd
