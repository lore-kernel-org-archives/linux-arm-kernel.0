From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Apr 2015 09:58:23 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401212854.GK4441@8bytes.org>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
 <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
 <20150401140512.GJ1552@arm.com>
 <1427898490.22236.10.camel@infradead.org>
 <20150401143904.GL1552@arm.com>
 <1427899570.22236.14.camel@infradead.org>
 <20150401163618.GN1552@arm.com> <20150401212854.GK4441@8bytes.org>
Message-ID: <20150402085821.GA18320@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 10:28:54PM +0100, joro at 8bytes.org wrote:
> On Wed, Apr 01, 2015 at 05:36:18PM +0100, Will Deacon wrote:
> > The issue (speaking in terms of the ARM SMMU, since that's what I'm familiar
> > with) is that we don't know the page sizes until we've chosen our
> > translation regime.
> 
> Can't you hard-code one regime in the driver and just don't use the
> others? Or might a SMMU only support a subset of the possible regimes?

Indeed, we can end up with systems that only support a subset of the
regimes. Different workloads may also benefit from different regimes due
to better TLB utilisation, but there's not currently a way to bias the page
table allocator away from the CPU page size.

Will
