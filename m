From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 17 Mar 2015 14:31:10 +0800
Subject: [update][PATCH v10 06/21] ACPI / sleep: Introduce
 CONFIG_ACPI_GENERIC_SLEEP
In-Reply-To: <5507C2C2.1090509@redhat.com>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org>
 <3737028.Ib0fKlgSkd@vostro.rjw.lan> <5507933F.2020203@huawei.com>
 <10995588.scpoK3KRg2@vostro.rjw.lan> <5507A91A.1090206@huawei.com>
 <5507C2C2.1090509@redhat.com>
Message-ID: <5507CA2E.3040600@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/17 13:59, Jon Masters wrote:
> On 03/17/2015 12:10 AM, Hanjun Guo wrote:
>> On 2015/3/17 11:23, Rafael J. Wysocki wrote:
>>> On Tuesday, March 17, 2015 10:36:47 AM Hanjun Guo wrote:
>>> Well, almost.  There is one problem with that, becuase sleep.c contains code
>>> outside of the ACPI_SLEEP-dependent blocks.  That code is used for powering
>>> off ACPI platforms.
>>>
>>> I guess you don't want that code on ARM too, right?
>> Yes, you are right.
>>> Perhaps we can use ACPI_REDUCED_HARDWARE_ONLY for that?  ARM64 will be the
>> Sorry, I can't fully understand your intention here, could you please
>> explain it more?
>>
>> Let me guess a little bit. Do you mean use ACPI_REDUCED_HARDWARE_ONLY for
>> powering off ACPI platforms? if so, I guess it's not a good idea, ACPI spec
>> only says that S4BIOS is not supported on HW-reduced ACPI platforms, S5
>> has no such limitation, if I miss something here, please let me know.
> If helpful to the discussion, current SBBR (Server Base Boot
> Requirements[0]) design guidance is that for power off itself, we will
> prefer calling an EFI Runtime Service (that will preferentially call an
> PSCI - ARM Power State Coordination Interface - Secure Monitor Call (SMC
> - think SMI-like) internally to perform the shutdown/reboot) for the
> action of powering off or resetting 64-bit ARM SBBR platforms.

Agreed, PSCI is the prefer method for power off on ARM64 I think.

>
> Therefore if the alternative of an ACPI-based power off solution were
> not initially supported, I don't think it would have much practical
> impact, and it could be addressed after the initial support merged.

I agree. Actually we already removed ACPI power off code for ARM64
in v9 and v10 regardless the ACPI sepc statement about S5, I just want to
confirm with Rafael that how to use ACPI_REDUCED_HARDWARE_ONLY properly
to do the same thing as we do in v10 (patch - ACPI / sleep: Introduce
CONFIG_ACPI_GENERIC_SLEEP), or if we have some other way to do that :)

Thanks
Hanjun
