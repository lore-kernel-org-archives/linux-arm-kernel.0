From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 4 Mar 2016 00:14:01 +0100
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56D7323B.4040100@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org> <56D7323B.4040100@codeaurora.org>
Message-ID: <56D8C539.9000203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
On 03/02/2016 07:34 PM, Sinan Kaya wrote:
> On 2/26/2016 12:15 PM, Eric Auger wrote:
>>> -module_init(reset ## _module_init);				\
>>>> +#define module_vfio_reset_handler(compat, acpihid, reset)		\
>>>> +MODULE_ALIAS("vfio-reset:" compat);					\
>> Here you need to handle alias for hid case I think
> 
> I'm wondering what happens when Compat or ACPI string is NULL.
> 
> MODULE_ALIAS("vfio-reset:" NULL)
> 
> Would the kernel like it? 

> 
> I'd rather create an alias only when the string is not NULL. Given
> this is a macro, I believe it won't work. 

Indeed I think we should create an alias only for the supported case or
2 aliases if both are supported.
> 
> Can you think of any other way in the code to create the alias?
> 
To be honest I did not find any elegant solution either. Personally I
would move the MODULE_ALIAS for compat/acpihid outside of
module_vfio_reset_handler macro, directly in the reset module. But maybe
someone will propose a better solution?

Best Regards

Eric
