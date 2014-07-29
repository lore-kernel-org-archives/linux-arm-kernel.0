From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Jul 2014 22:07:40 +0800
Subject: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <53D7A6A2.9020005@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org>
 <53D69678.20002@arm.com> <53D79CD8.9050709@linaro.org>
 <53D7A6A2.9020005@arm.com>
Message-ID: <53D7AAAC.6070606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?07?29? 21:50, Sudeep Holla wrote:
>
> On 29/07/14 14:08, Hanjun Guo wrote:
>> On 2014-7-29 2:29, Sudeep Holla wrote:
>> [...]
>>>> +
>>>> +/*
>>>> + * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
>>>> + * variable is still required by the ACPI core
>>>> + */
>>>> +u32 acpi_rsdt_forced;
>>>
>>> This looks like yet another stray variable not used anywhere including
>>> core ACPI
>>
>> It will be used by ACPICA to get the RSDP in acpi_tb_parse_root_table()
>> in tbutils.c.
>>
>
> No I couldn't find it in mainline/acpica/linux-next(pm tree).
>
> On further digging found that commit fab461058385("ACPICA: Cleanup the
> option of forcing the use of the RSDT") has renamed it to
> acpi_gbl_do_not_use_xsdt and moved it into acpica with default false.
> So you can remove this.

Ah, my bad. I grepped it in another version of kernel and found the outdated
result, I will update this patch.

Thanks
Hanjun
