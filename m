From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Apr 2014 16:46:33 +0800
Subject: [Linaro-acpi] [PATCH v3 part1 06/11] ARM64 / ACPI: Introduce
 lowlevel suspend function
In-Reply-To: <20140428152240.GD31782@e102568-lin.cambridge.arm.com>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-7-git-send-email-hanjun.guo@linaro.org>
 <20140428152240.GD31782@e102568-lin.cambridge.arm.com>
Message-ID: <535F66E9.3030307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2014-4-28 23:22, Lorenzo Pieralisi wrote:
> On Fri, Apr 25, 2014 at 02:20:12PM +0100, Hanjun Guo wrote:
>> acpi_wakeup_address is used on x86 as the address bios jumps into
>> when machine wakes up from suspend. As arm64 does not have such a
>> bios this mechanism will be provided by other means. But the define
>> is still required inside the acpi core.
>>
[...]
>>  #define cpu_physical_id(cpu) -1
>>  
>> +/* Low-level suspend routine. */
>> +extern int (*acpi_suspend_lowlevel)(void);
>> +#define acpi_wakeup_address (0)
> 
> I understand you want code to compile, but as I mentioned in another
> thread, I would focus more on understanding if these macros/hooks are
> really needed for ARM rather than defining them _just_ to make code
> compile. The fact that you are forced to define them makes me think
> there is something to be changed in ACPI core code instead of adding
> empty and probably useless macros/hooks for ARM which I have no idea
> whatsoever whether will ever be needed or not.

Ok, we will deep into ACPI core to find out how to handle it, thanks
for your suggestion.

Hanjun
