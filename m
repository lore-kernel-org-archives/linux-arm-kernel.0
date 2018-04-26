From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 14:11:36 +0200
Subject: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
 API
In-Reply-To: <20180425151934.GC16075@infradead.org>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-2-thierry.reding@gmail.com>
 <20180425151934.GC16075@infradead.org>
Message-ID: <20180426121136.GD11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The dma_iommu_detach_device() API can be used by drivers to forcibly
> > detach a device from an IOMMU that architecture code might have attached
> > to. This is useful for drivers that need explicit control over the IOMMU
> > using the IOMMU API directly.
> 
> Given that no one else implements it making it a generic API seems
> rather confusing.  For now I'd rename it to
> arm_dma_iommu_detach_device() and only implement it in arm.

That'd be suboptimal because this code is used on both 32-bit and 64-bit
ARM. If we make the function 32-bit ARM specific then the driver code
would need to use an #ifdef to make sure compilation doesn't break on
64-bit ARM.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/550c5cea/attachment.sig>
