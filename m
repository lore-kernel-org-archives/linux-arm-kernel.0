From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 13 Nov 2016 22:10:40 -0500
Subject: [PATCH V2] dmaengine: qcom_hidma: cleanup sysfs entries during
 remove
In-Reply-To: <20161114030452.GH3000@localhost>
References: <1476902566-26676-1-git-send-email-okaya@codeaurora.org>
 <20161114030452.GH3000@localhost>
Message-ID: <457a0a58-fcb5-26d6-99e6-7192dd071e1c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2016 10:04 PM, Vinod Koul wrote:
> On Wed, Oct 19, 2016 at 02:42:46PM -0400, Sinan Kaya wrote:
>> The 4.8-rc8 kernel is printing duplicate file entry warnings while removing
>> the HIDMA object. This is caused by stale sysfs entries remaining from the
>> previous execution.
>>
>> _sysfs_warn_dup+0x5c/0x78
>>  sysfs_add_file_mode_ns+0x13c/0x1c0
>>  sysfs_create_file_ns+0x2c/0x40
>>  device_create_file+0x54/0xa0
>>  hidma_probe+0x7c8/0x808
>>
>> Create hidma_sysfs_init and hidma_sysfs_uninit functions and call them from
>> the probe and remove path. To do proper clean up, adding the attrs object
>> to the device data structure to keep it around until remove call is made.
> 
> This doesnt apply for me, I think due to other patches applied..
> 

OK. Let me rebase.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
