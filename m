From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 12 Dec 2017 14:17:48 -0600
Subject: [PATCH 4/4] [v4] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <1513073105.25007.618.camel@linux.intel.com>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
 <1512170904-4749-5-git-send-email-timur@codeaurora.org>
 <1513073105.25007.618.camel@linux.intel.com>
Message-ID: <bae16fa3-1bdf-74b1-97b7-f6b2db212621@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 04:05 AM, Andy Shevchenko wrote:
>> +static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
>> +	{"QCOM8001", QDF2XXX_V1},
>> +	{"QCOM8002", QDF2XXX_V2},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
>>
>> +	const struct acpi_device_id *id =
>> +		acpi_match_device(qdf2xxx_acpi_ids, &pdev->dev);
> JFYI: there is no need to move IDs like this.
> Use members of struct device_driver wisely.

I have to move it, otherwise I get:

drivers/pinctrl/qcom/pinctrl-qdf2xxx.c:49:21: error: 'qdf2xxx_acpi_ids' 
undeclared (first use in this function); did you mean 'qdf2xxx_pinctrl'?

I reference the structure in qdf2xxx_pinctrl_probe().

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
