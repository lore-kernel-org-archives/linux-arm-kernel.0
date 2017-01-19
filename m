From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 19 Jan 2017 19:06:10 +0800
Subject: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
Message-ID: <CADyBb7sA_sMmTcBtXDSNNFzZ_BjVAUL+c-FXWmHaEnH_SXyCUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 19 January 2017 at 17:20, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Fuwei,
>
>
> On 2017/1/18 21:25, fu.wei at linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Clean up printk() usage
>>         2. Rename the type macros
>>         3. Rename the PPI enum & enum values
>>         4. Move the type macro and PPI enum into the header file
>>         5. Add new enum for SPIs
>>         6. Rework PPI determination;
>>         7. Rework counter frequency detection;
>>         8. Refactor arch_timer_needs_probing, move it into DT init call
>>         9. Introduce some new structs and refactor the MMIO timer init
>> code
>>         for reusing some common code.
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer.
>>
>> This patchset has been tested on the following platforms with ACPI
>> enabled:
>>     (1)ARM Foundation v8 model
>>
>> Changelog:
>> v20: https://lkml.org/lkml/2017/1/18/
>>      Reorder the first 4 patches and split the 4th patches.
>>      Leave CNTHCTL_* as they originally were.
>>      Fix the bug in arch_timer_select_ppi.
>>      Split "Rework counter frequency detection" patch.
>>      Rework the arch_timer_detect_rate function.
>>      Improve the commit message of "Refactor MMIO timer probing".
>>      Rebase to 4.10.0-rc4
>
>
> Other than some minor comments I raised, the patch set
> looks fine to me, and I tested this patch set on D03,
> the percpu arch timer works fine as before.
>
> With the comments fixed,
> Reviewed-by: Hanjun Guo <hanjun.gu@linaro.org>
> Tested-by: Hanjun Guo <hanjun.gu@linaro.org>

Great thanks for your testing. :-)

will apply Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org> on all patches,
and Tested-by: Hanjun Guo <hanjun.guo@linaro.org> on arch_timer patches.

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
