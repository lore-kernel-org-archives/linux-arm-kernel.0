From: linuc.decode@gmail.com (Linu Cherian)
Date: Tue, 27 Jun 2017 14:38:24 +0530
Subject: [PATCH v2 5/8] iommu/io-pgtable-arm: Support lockless operation
In-Reply-To: <20170627083912.GA5759@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
 <af61929e3984a31588cab08ed84a237602b5263e.1498145008.git.robin.murphy@arm.com>
 <20170623055326.GA2949@virtx40> <20170623085607.GC3718@virtx40>
 <7a8da378-19e2-2f35-877a-cc6ce389301a@arm.com>
 <20170623113405.GA5221@virtx40> <20170627051155.GA9525@virtx40>
 <20170627083912.GA5759@arm.com>
Message-ID: <20170627090824.GA2758@virtx40>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue Jun 27, 2017 at 09:39:13AM +0100, Will Deacon wrote:
> On Tue, Jun 27, 2017 at 10:41:55AM +0530, Linu Cherian wrote:
> > On Fri Jun 23, 2017 at 05:04:05PM +0530, Linu Cherian wrote:
> > > On Fri Jun 23, 2017 at 11:35:25AM +0100, Robin Murphy wrote:
> > > > Note that on a coherent platform like ThunderX that's as good as just
> > > > deleting it, because you'll never execute the case below. However, on
> > > > reflection I think it can at least safely be downgraded to dma_wmb()
> > > > (i.e. DMB) rather than a full DSB - would you be able to test what
> > > > difference that makes?
> > > 
> > > The testing was done on Thunderx 1, which has a non coherent page table walk.
> > > Yes, downgrading to dma_wmb() helps. With this change, performance is back to v1.
> > > 
> > 
> > Should i send a patch for this ?
> 
> I already did it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/updates&id=77f3445866c39d8866b31d8d9fa47c7c20938e05
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks Will.

-- 
Linu cherian
