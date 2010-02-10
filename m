From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 10 Feb 2010 15:10:38 -0800
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <20100210224030.GC30854@n2100.arm.linux.org.uk>
References: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>
	<4B7324D3.1000509@xenotime.net>
	<20100210224030.GC30854@n2100.arm.linux.org.uk>
Message-ID: <4B733CEE.9030105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2010 at 01:27:47PM -0800, Randy Dunlap wrote:
>> On 02/10/10 12:37, adharmap at codeaurora.org wrote:
>>> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
>>>
>>> Please refer to the post here
>>> http://lkml.org/lkml/2010/1/4/347
>>>
>>> These changes are to introduce barrierless dma_map_area and dma_unmap_area and
>>> use them to map the buffers in the scatterlist. For the last buffer, call
>>> the normal dma_map_area(aka with barriers) effectively executing the barrier
>>> at the end of the operation.
>>>
>>> Note that the barrierless operations are implemented for few arm
>>> architectures only and I would implement for others once these are okayed by the
>>> community.
>> So when you add these interfaces for other architectures, you will also
>> update Documentation/DMA-API.txt,  right??
> 
> Do we need barrier-less interfaces for anything other than the dma_*_sg
> functions?

I think, dma_*_sg are the only ones that could benefit from barrier-less 
interfaces.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
