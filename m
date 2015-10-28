From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 28 Oct 2015 11:01:05 +0000
Subject: [PATCH 1/2] arm64: Workaround renaming of __GFP_WAIT
In-Reply-To: <20151028005333.GH27420@8bytes.org>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
 <20151028005333.GH27420@8bytes.org>
Message-ID: <5630AAF1.1050500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 28/10/15 00:53, Joerg Roedel wrote:
> Hi Robin,
>
> On Fri, Oct 16, 2015 at 04:33:41PM +0100, Robin Murphy wrote:
>> The imminent renaming of __GFP_WAIT in the mm tree conflicts with its
>> use in the new IOMMU DMA ops; introduce a temporary local version of
>> its replacement to smooth over the transition.
>>
>> This patch should be reverted at 4.4-rc1.
>
> I lost track here, are these two patches required in the iommu tree for
> the next merge window?

Andrew has the equivalent of patch 2 as a fixup on top of Mel's series, 
which Stephen is currently carrying as a merge resolution in -next. I'm 
assuming this will go into the final merge as well, so as long as Linus 
takes the IOMMU tree first we should be OK as-is.

Robin.

>
>
> 	Joerg
>
