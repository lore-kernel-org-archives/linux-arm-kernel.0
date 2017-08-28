From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 28 Aug 2017 11:29:23 -0400
Subject: [PATCH] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
In-Reply-To: <877exnyh9i.fsf@linux.intel.com>
References: <1503684135-24207-1-git-send-email-awallis@codeaurora.org>
 <877exnyh9i.fsf@linux.intel.com>
Message-ID: <a4f5b82e-a211-f3e1-9ef3-e1622ad3420f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/2017 9:05 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Adam Wallis <awallis@codeaurora.org> writes:
>> The dma ops from the parent DWC device are not getting passed to the
>> child xhci-hcd device. This patch makes use of
>> platform_device_register_full to set the DMA ops. For the DT/OF case,
>> dma_ops were still null after the the device register, so
>> of_dma_configure is called in only the OF case.
>>
>> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> 
> you need to sysdev property, IMO.
> 
Thanks, good suggestion. I will test that out.

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
