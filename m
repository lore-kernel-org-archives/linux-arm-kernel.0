From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 27 Feb 2015 18:51:43 +0800
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54F02CB6.2090508@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <54EFE282.1090305@codeaurora.org> <54F02CB6.2090508@linaro.org>
Message-ID: <54F04C3F.7040201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/27 16:37, Hanjun Guo wrote:
> Hi Timur,
> 
> On 2015?02?27? 11:20, Timur Tabi wrote:
>> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>>> Changes since v8:
>>
>> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after
>> calling the UEFI boot time services exit function.  That is, this line:
>>
>> status = sys_table->boottime->exit_boot_services(handle, mmap_key);
>>
>> in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
>> returns, the kernel crashes.  It's really early because the UEFI
>> exception handler is called.
>>
>> I did not have this problem with v8 patchset on 3.19.
> 
> I tested this patch set on FVP base model with UEFI, and booted ok.
> Can you boot the system without this ACPI patch set?
> 
>>
>>
>> Also, you still have a couple whitespace problems in these patches:
>>
>> Applying: ARM64 / ACPI: additions of ACPI documentation for arm64
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:607: new blank line
>> at EOF.
>> +
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:844: new blank line
>> at EOF.
>> +
>> warning: 2 lines add whitespace errors.
>> Applying: Documentation: ACPI for ARM64
>> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:517: new blank line
>> at EOF.
>> +
>> warning: 1 line adds whitespace errors.
> 
> Weired, When I checked the patch locally there were no whitespace
> problems:

I found those whitespace errors too. Please see the comments in each patch.

-- 
Thanks,
Shannon
