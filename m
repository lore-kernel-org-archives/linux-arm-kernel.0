From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 2 Mar 2016 13:34:35 -0500
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56D08843.5020306@linaro.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org>
Message-ID: <56D7323B.4040100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/26/2016 12:15 PM, Eric Auger wrote:
>> -module_init(reset ## _module_init);				\
>> > +#define module_vfio_reset_handler(compat, acpihid, reset)		\
>> > +MODULE_ALIAS("vfio-reset:" compat);					\
> Here you need to handle alias for hid case I think

I'm wondering what happens when Compat or ACPI string is NULL.

MODULE_ALIAS("vfio-reset:" NULL)

Would the kernel like it? 

I'd rather create an alias only when the string is not NULL. Given
this is a macro, I believe it won't work. 

Can you think of any other way in the code to create the alias?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
