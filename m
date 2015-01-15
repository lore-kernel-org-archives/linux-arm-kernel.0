From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Jan 2015 18:35:03 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <1421136128.27675.58.camel@mtksdaap41>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <1421136128.27675.58.camel@mtksdaap41>
Message-ID: <54B80857.7060407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/15 08:02, Yingjoe Chen wrote:
> On Mon, 2015-01-12 at 20:48 +0000, Robin Murphy wrote:
>> Hi all,
>>
>> Whilst it's a long way off perfect, this has reached the point of being
>> functional and stable enough to be useful, so here it is. The core
>> consists of the meat of the arch/arm implementation modified to remove
>> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
>> allocator instead of the bitmap-based one. For that, this series depends
>> on my "Genericise the IOVA allocator" series posted earlier[1].
>
> Hi Robin,
>
> We'd to give it a try. Do you have a public git tree contains both
> series?
>
> Joe.C

Now that the server seems to be properly accessible again, I've made a 
branch with both series available here:

   git://linux-arm.org/linux-rm iommu/dma

Note that in the current state it also depends on having the ARM SMMU 
driver selected in the config, due to an oversight on my part :(

Robin.
