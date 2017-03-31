From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Mar 2017 13:40:51 +0100
Subject: [PATCH 0/3] IOVA allocation improvements for iommu-dma
In-Reply-To: <cover.1489581865.git.robin.murphy@arm.com>
References: <cover.1489581865.git.robin.murphy@arm.com>
Message-ID: <20170331124051.GI8967@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin, Joerg,

On Wed, Mar 15, 2017 at 01:33:13PM +0000, Robin Murphy wrote:
> Here's the first bit of lock contention removal to chew on - feedback
> welcome! Note that for the current users of the io-pgtable framework,
> this is most likely to simply push more contention onto the io-pgtable
> lock, so may not show a great improvement alone. Will and I both have
> rough proof-of-concept implementations of lock-free io-pgtable code
> which we need to sit down and agree on at some point, hopefullt fairly
> soon.
> 
> I've taken the opportunity to do a bit of cleanup and refactoring
> within the series to make the final state of the code nicer, but the
> diffstat still turns out surprisingly reasonable in the end - it would
> actually be negative but for the new comments!
> 
> Magnus, Shimoda-san, the first two patches should be of interest as they
> constitute the allocation rework I mentioned a while back[1] - if you
> still need to implement that scary workaround, this should make it
> simple to hook IPMMU-specific calls into the alloc and free paths, and
> let the driver take care of the details internally.

What's the plan for merging this? Whilst we still have the iopgtable lock
contention to resolve, this is a good incremental step towards improving
our scalability and sits nicely alongside the SMMUv2 TLB improvements I
just queued.

Thanks,

Will
