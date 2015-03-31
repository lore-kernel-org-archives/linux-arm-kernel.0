From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 31 Mar 2015 17:47:25 +0300
Subject: [PATCH v3 5/7] dmaengine: omap-dma: Take DMA request number from
 DT if it is available
In-Reply-To: <20150327202446.GB4027@n2100.arm.linux.org.uk>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com>
 <20150327202446.GB4027@n2100.arm.linux.org.uk>
Message-ID: <551AB37D.1090104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 10:24 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 27, 2015 at 02:26:51PM +0200, Peter Ujfalusi wrote:
>> +	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
>> +						       "dma-requests",
>> +						       &od->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing dma-requests property, using %u.\n",
>> +			 OMAP_SDMA_REQUESTS);
>> +		od->dma_requests = OMAP_SDMA_REQUESTS;
>> +	}
> 
> Are all OMAPs including OMAP1 being converted to DT?  If not, don't
> introduce noisy printks for which a platform can't do anything about.
> Think about this please - if there's no of_node, then why complain
> about a missing OF property?

Yes, you are perfectly right on this. Will fix it up.

Thanks,
P?ter
