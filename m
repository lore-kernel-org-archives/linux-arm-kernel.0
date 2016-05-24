From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 23 May 2016 22:25:17 -0400
Subject: [PATCH V5 5/6] vfio: platform: call _RST method when using ACPI
In-Reply-To: <57431FF7.2060807@linaro.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-6-git-send-email-okaya@codeaurora.org>
 <57431FF7.2060807@linaro.org>
Message-ID: <5743BB8D.7050408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/23/2016 11:21 AM, Eric Auger wrote:
>> +	acpi_ret = acpi_evaluate_integer(handle, "_RST", NULL, &val);
>> > +	if (ACPI_FAILURE(acpi_ret))
>> > +		return -EINVAL;
> Can't you return something more explicit here? The error code will be
> visible to the userspace. Difficult for him to understand the cause of
> the failure in that case.

I can also add a reset failed message to both DT and ACPI reset calls.

Will that work?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
