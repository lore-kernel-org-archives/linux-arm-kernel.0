From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Tue, 10 Jan 2017 17:01:58 +0300
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110115132.GD21598@arm.com>
 <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
 <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
Message-ID: <24c5a31e-0148-315b-19b3-0aec456e1164@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> What issue "IOMMU doesn't solve"?
>>
>> Issue I'm trying to address is - inconsistency within swiotlb
>> dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
>> mask is used to decide if bounce buffers are needed or not. This
>> inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
>> instead).
> 
> The fundamental underlying problem is the "any wide mask is silently
> accepted" part, and that applies equally to IOMMU ops as well.

Is just posted version better?

It should cover iommu case as well.

Nikita
