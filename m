From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 8 Mar 2016 10:44:48 -0500
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56DE5E11.3060307@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org> <56D7323B.4040100@codeaurora.org>
 <56D8C539.9000203@linaro.org> <56D91B0E.1080203@codeaurora.org>
 <56DCFEE0.6080101@linaro.org> <56DD9E7E.6000406@codeaurora.org>
 <56DE592E.6010403@linaro.org> <56DE5E11.3060307@codeaurora.org>
Message-ID: <56DEF370.3000904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3/8/2016 12:07 AM, Sinan Kaya wrote:
> On 3/7/2016 11:46 PM, Eric Auger wrote:
>>> #define module_vfio_reset_handler(compat, acpihid, reset) \
>>>> MODULE_ALIAS("vfio-reset: dt: " compat); \
>>>> MODULE_ALIAS("vfio-reset: acpi: " acpihid); \
>> My gut feeling is we must not create a dummy alias when the mode
>> (dt/acpi) is not supported/tested. It fills the modinfo section with
>> spurious data, aliases are visible to modinfo, ...
>>
>> So I personally foresee 2 solutions,
>> 1) we create a single alias using acpihid if supported or compat if not.
>> Then even in dt mode we try to load this module through the acpihid
>> alias. Looks weird but should work.
>> 2) We simply move the module alias declaration out of this macro (to the
>> reset module itself), define 2 aliases in case both dt and acpi are
>> supported & tested.
>>
>> My personal preference is 2 I think.
>>
>> Best Regards
>>
>> Eric
>>
> 
> I agree with your assessment of #2. We are trying to be too smart. 
> I'll post a patch with #2 solution.
> 

I split patch 8 and 9 from the series and posted a new set here.

http://www.spinics.net/lists/arm-kernel/msg489578.html

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
