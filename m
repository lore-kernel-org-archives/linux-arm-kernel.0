From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 30 Jun 2016 09:29:59 +0800
Subject: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <CAJZ5v0iD5OYjp7ozmzoQ3zK-3+eMpdwzDxYgD=saLPjNeoq0Qg@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0iD5OYjp7ozmzoQ3zK-3+eMpdwzDxYgD=saLPjNeoq0Qg@mail.gmail.com>
Message-ID: <CADyBb7vmS=oJ9EOzs-v-O4_h5Kd_PCMQytjqEHdRNQkqz4WHcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 30 June 2016 at 05:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jun 29, 2016 at 8:15 PM,  <fu.wei@linaro.org> wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer
>>         1. Move some enums and marcos to header file
>>         2. Add a new enum for spi type.
>>         3. Improve printk relevant code
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer
>
> GTDT is ARM-specific AFAICS.

yes, you are right, it is.

>
> If so, why do we need that code to reside in drivers/acpi/ ?

Although  the GTDT is just for ARM64, but this driver is parsing one
of ACPI table,
I think that could be treated as ACPI driver.  Do I miss something? :-)

>
> Thanks,
> Rafael



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
