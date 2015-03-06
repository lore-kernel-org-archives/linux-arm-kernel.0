From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Mar 2015 11:59:10 +0000
Subject: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
 struct iommu_domain
In-Reply-To: <3242222.7VyhtFfsx7@avalon>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
 <1425641688-26438-2-git-send-email-will.deacon@arm.com>
 <3242222.7VyhtFfsx7@avalon>
Message-ID: <20150306115909.GJ22377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:56:08AM +0000, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

Cheers for taking a look.

> On Friday 06 March 2015 11:34:47 Will Deacon wrote:
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 10186cac7716..cd867b255b99 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -469,6 +469,7 @@ static int ipmmu_domain_init(struct iommu_domain
> > *io_domain)
> > 
> >  	io_domain->priv = domain;
> >  	domain->io_domain = io_domain;
> > +	domain->pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K;
> 
> You're changing the bitmap, was it intended ?

Yikes, no, sorry about that. It looks like this is due to a bad rebase (I
build tested everything, but don't have an ipmmu-vmsa to run on). You
changed the bitmap in f20ed39f531 when you moved to the generic allocator
and I didn't pick up the change here. Will fix.

Will
