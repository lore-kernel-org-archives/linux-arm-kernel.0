From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 14 Nov 2016 14:37:12 -0500
Subject: [PATCH V2] dmaengine: qcom_hidma: cleanup sysfs entries during
 remove
In-Reply-To: <457a0a58-fcb5-26d6-99e6-7192dd071e1c@codeaurora.org>
References: <1476902566-26676-1-git-send-email-okaya@codeaurora.org>
 <20161114030452.GH3000@localhost>
 <457a0a58-fcb5-26d6-99e6-7192dd071e1c@codeaurora.org>
Message-ID: <e3cf2215-2f64-66a2-7313-0893423b8250@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 11/13/2016 10:10 PM, Sinan Kaya wrote:
> On 11/13/2016 10:04 PM, Vinod Koul wrote:
>> On Wed, Oct 19, 2016 at 02:42:46PM -0400, Sinan Kaya wrote:
>>> The 4.8-rc8 kernel is printing duplicate file entry warnings while removing
>>> the HIDMA object. This is caused by stale sysfs entries remaining from the
>>> previous execution.
>>>
>>> _sysfs_warn_dup+0x5c/0x78
>>>  sysfs_add_file_mode_ns+0x13c/0x1c0
>>>  sysfs_create_file_ns+0x2c/0x40
>>>  device_create_file+0x54/0xa0
>>>  hidma_probe+0x7c8/0x808
>>>
>>> Create hidma_sysfs_init and hidma_sysfs_uninit functions and call them from
>>> the probe and remove path. To do proper clean up, adding the attrs object
>>> to the device data structure to keep it around until remove call is made.
>>
>> This doesnt apply for me, I think due to other patches applied..
>>
> 
> OK. Let me rebase.
> 

I fetched your topic/qcom branch and applied this patch on top. 

This is what I see at this moment.

22f20f5 dmaengine: qcom_hidma: cleanup sysfs entries during remove
8cc12b2 dmaengine: qcom_hidma: hide MSI handler when unused
87ffcea dmaengine: qcom_hidma: remove unneeded of_node_put()
1c0e3e8 dmaengine: qcom_hidma: add MSI support for interrupts

I posted V3 a minute ago with the contents of 22f20f5.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
