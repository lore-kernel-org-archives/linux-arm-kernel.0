From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 26 Nov 2015 12:32:57 +0000
Subject: [PATCH] arm64/dma-mapping: Fix sizes in __iommu_{alloc,free}_attrs
In-Reply-To: <20151126123002.GJ2064@8bytes.org>
References: <74bd0f4e1ecda45febc55c6c6fe0d3d616c283d0.1446643360.git.robin.murphy@arm.com>
 <20151126123002.GJ2064@8bytes.org>
Message-ID: <5656FBF9.2070703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 26/11/15 12:30, Joerg Roedel wrote:
> On Wed, Nov 04, 2015 at 01:23:52PM +0000, Robin Murphy wrote:
>> The iommu-dma layer does its own size-alignment for coherent DMA
>> allocations based on IOMMU page sizes, but we still need to consider
>> CPU page sizes for the cases where a non-cacheable CPU mapping is
>> created. Whilst everything on the alloc/map path seems to implicitly
>> align things enough to make it work, some functions used by the
>> corresponding unmap/free path do not, which leads to problems freeing
>> odd-sized allocations. Either way it's something we really should be
>> handling explicitly, so do that to make both paths suitably robust.
>>
>> Reported-by: Yong Wu <yong.wu@mediatek.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
> Has this been merged through the arm tree or should I submit it as a fix
> for 4.4?

It's in -rc2 already, via the arm64 tree.

Thanks,
Robin.

>
>
> 	Joerg
>
