From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 14:21:13 +0000
Subject: [PATCH v3 3/3] iommu/io-pgtable: Avoid redundant TLB syncs
In-Reply-To: <81a5e784494a04713e152659c95b34e92d944f32.1453723096.git.robin.murphy@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
 <81a5e784494a04713e152659c95b34e92d944f32.1453723096.git.robin.murphy@arm.com>
Message-ID: <20160210142112.GK1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 05:13:15PM +0000, Robin Murphy wrote:
> In certain unmapping situations it is quite possible to end up issuing
> back-to-back TLB synchronisations, which at best is a waste of time and
> effort, and at worst causes some hardware to get rather confused. Whilst
> the pagetable implementations, or the IOMMU drivers, or both, could keep
> track of things to avoid this happening, it seems to make the most sense
> to prevent code duplication and add some simple state tracking in the
> common interface between the two.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
