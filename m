From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 7 Dec 2017 09:45:31 -0500
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <20171207141029.575c0a03@karo-electronics.de>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
 <20171207141029.575c0a03@karo-electronics.de>
Message-ID: <def8e351-bc2d-7adc-fdc5-362b365302a8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2017 8:10 AM, Lothar Wa?mann wrote:
>> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
>> +			       struct device *dev)
> Shouldn't this be 'const void *of_fwnode_get_match_data

OF keeps the driver data as a (const void*) internally. ACPI keeps the
driver data as kernel_ulong_t in struct acpi_device_id.

I tried to find the middle ground here by converting output to void*
but not keeping const.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
