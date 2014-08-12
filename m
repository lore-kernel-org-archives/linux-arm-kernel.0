From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 12 Aug 2014 09:53:44 -0700
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <20140812013559.GA25121@laptop.dumpdata.com>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <20140812013559.GA25121@laptop.dumpdata.com>
Message-ID: <53EA4698.9020608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/11/2014 6:35 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
> .. snip..
>> +	for_each_sg(sg, s, nents, i) {
>> +		phys_addr_t phys = page_to_phys(sg_page(s));
>> +		size_t page_len = s->offset + s->length;
>> +
>> +		ret = iommu_map(domain, iova + offset, phys, page_len,
>> +				prot);
>> +		if (ret) {
>> +			/* undo mappings already done */
>> +			iommu_unmap(domain, iova, offset);
> 
> Don't we want then to unmap all of the scatter list instead of just
> the last one?
> 

It reverts all the mapping that was already done up until the error
occurred. "offset" contains the amount we have mapped so far.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
