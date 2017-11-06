From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 6 Nov 2017 13:15:43 -0500
Subject: [PATCH 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <428c7106-8ebe-0c12-4576-1cfac422923e@arm.com>
References: <1509989180-22617-1-git-send-email-okaya@codeaurora.org>
 <1509989180-22617-2-git-send-email-okaya@codeaurora.org>
 <428c7106-8ebe-0c12-4576-1cfac422923e@arm.com>
Message-ID: <0b24eb03-1f0e-ec65-b12b-65036ef7addc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2017 1:03 PM, Robin Murphy wrote:
>>  #ifdef CONFIG_ACPI
>>  		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
>> +		if (ret)
>> +			ret = strcmp(acpi_device_hid(adev), "QCOM8063");
> This string-juggling looks to have already hit the point at which it
> doesn't scale well - it would be a lot nicer to make use of
> of_device_get_match_data() and the ACPI equivalent to abstract the
> version-specific data appropriately.

Sure, let me do some research.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
