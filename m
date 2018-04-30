From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Apr 2018 13:02:31 +0200
Subject: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
 API
In-Reply-To: <20180426121136.GD11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-2-thierry.reding@gmail.com>
 <20180425151934.GC16075@infradead.org>
 <20180426121136.GD11985@ulmo>
Message-ID: <20180430110231.GF2476@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 02:11:36PM +0200, Thierry Reding wrote:
> On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
> > On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > The dma_iommu_detach_device() API can be used by drivers to forcibly
> > > detach a device from an IOMMU that architecture code might have attached
> > > to. This is useful for drivers that need explicit control over the IOMMU
> > > using the IOMMU API directly.
> > 
> > Given that no one else implements it making it a generic API seems
> > rather confusing.  For now I'd rename it to
> > arm_dma_iommu_detach_device() and only implement it in arm.
> 
> That'd be suboptimal because this code is used on both 32-bit and 64-bit
> ARM. If we make the function 32-bit ARM specific then the driver code
> would need to use an #ifdef to make sure compilation doesn't break on
> 64-bit ARM.

Do you still want me to make this ARM specific? While I haven't
encountered this issue on 64-bit ARM yet, I think it would happen there
as well, under the right circumstances. I could take a shot at
implementing the equivalent there (which means essentially implementing
it for drivers/iommu/dma-iommu.c and calling that from 64-bit ARM code).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180430/c99db340/attachment.sig>
