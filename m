From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 22 Jun 2017 13:47:01 +0100
Subject: [PATCH v5 1/7] dma: Take into account dma_pfn_offset
In-Reply-To: <20170620132400.GB11370@infradead.org>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-2-git-send-email-vladimir.murzin@arm.com>
 <20170620132400.GB11370@infradead.org>
Message-ID: <593f90fe-f7e1-a86c-5376-8ed775c65592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 14:24, Christoph Hellwig wrote:
>> -		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
>> +		sg_dma_address(sg) = (dma_addr_t)(virt_to_phys(va) - PFN_PHYS(dev->dma_pfn_offset));
> 
> Needs a line break instead of the overly long line.

Will do.

> 
> Otherwise this looks fine to me.
> 

Thanks
Vladimir
