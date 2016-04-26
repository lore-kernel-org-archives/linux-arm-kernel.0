From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 26 Apr 2016 11:14:15 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <87d1pcrj0t.fsf@intel.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <87d1pcrj0t.fsf@intel.com>
Message-ID: <571F2357.9080509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2016 09:17 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> Now not all DMA paremters configured properly for "xhci-hcd" platform
>> device which is created manually. For example: dma_pfn_offset, dam_ops
>> and iommu configuration will not corresponds "dwc3" devices
>> configuration. As result, this will cause problems like wrong DMA
>> addresses translation on platforms with LPAE enabled like Keystone 2.
>>
>> When platform is using DT boot mode the DMA configuration will be
>> parsed and applied from DT, so, to fix this issue, reuse
>> of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
>> from DWC3 device node.
> 
> patch is incomplete. You left out non-DT users which might suffer from
> the same problem.
> 

Honestly, I don't know how to fix it gracefully for non-DT case.
I can update commit message to mention that this is fix for DT case only.


-- 
regards,
-grygorii
