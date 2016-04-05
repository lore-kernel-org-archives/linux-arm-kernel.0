From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 Apr 2016 15:33:10 +0200
Subject: [PATCH 1/2] iommu/dma: Restore scatterlist offsets correctly
In-Reply-To: <5703B98A.6010200@arm.com>
References: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
 <20160405125926.GI17838@8bytes.org> <5703B98A.6010200@arm.com>
Message-ID: <20160405133310.GA9516@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 02:11:38PM +0100, Robin Murphy wrote:
> On 05/04/16 13:59, Joerg Roedel wrote:
> >On Thu, Mar 10, 2016 at 07:28:12PM +0000, Robin Murphy wrote:
> >>With the change to stashing just the IOVA-page-aligned remainder of the
> >>CPU-page offset rather than the whole thing, the failure path in
> >>__invalidate_sg() also needs tweaking to account for that in the case of
> >>differing page sizes where the two offsets may not be equivalent.
> >>Similarly in __finalise_sg(), lest the architecture-specific wrappers
> >>later get the wrong address for cache maintenance on sync or unmap.
> >>
> >>Fixes: 164afb1d85b8 ("iommu/dma: Use correct offset in map_sg")
> >>Reported-by: Magnus Damm <damm+renesas@opensource.se>
> >>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >
> >Cc: stable at ver.kernel.org # v4.4+ ?
> 
> Good point - the kind of people using 64k pages are also likely to
> be the ones sticking to stable kernels. Are you able to handle that,
> or would you like me to resend?

I added the tag and put the commit into my iommu/fixes branch. Can you
re-send me the second commit when the first is upstream (I'll send the
pull-req this week)? I'd like to avoid creating an additional
merge-commit just for this patch.


	Joerg
