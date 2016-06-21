From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 21 Jun 2016 09:34:11 +0100
Subject: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <576863BF.6040800@arm.com> (Jeremy Linton's message of "Mon, 20
 Jun 2016 16:44:31 -0500")
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
 <87h9cn6ckw.fsf@e105922-lin.cambridge.arm.com>
 <576863BF.6040800@arm.com>
Message-ID: <87r3br3pq4.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> Hi Punit,
>
> On 06/20/2016 11:37 AM, Punit Agrawal wrote:
>> Jeremy Linton <jeremy.linton@arm.com> writes:
>>
>>> Its possible that an ACPI system has multiple CPU types in it
>>> with differing PMU counters. Use the newly provided acpi_pmu routines
>>> to detect that case, and instantiate more than one set of counters.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/perf/arm_pmu.c      |  7 +++-
>>>   drivers/perf/arm_pmu_acpi.c | 98 ++++++++++++++++++++-------------------------
>>>   2 files changed, 50 insertions(+), 55 deletions(-)
>>>

[...]

>>> @@ -47,7 +52,7 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>>>   }
>>>
>>>   /* Count number and type of CPU cores in the system. */
>>> -void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>> +static void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>>   {
>>>   	int i, j;
>>>
>>
>> Please move this and the following two hunks to the previous patch where you
>> introduce the functions.
>
>
> Oh, I did this on purpose to avoid:
>
> "warning: 'xxx' defined but not used" messages.
>

In that case, I'd suggest merging the patches. IMO, it's better to have
self-contained patches be they slightly large than to introduce
artifacts like here.

>
>
>>
>>> @@ -74,7 +79,7 @@ void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>>    * Registers the group of PMU interfaces which corrispond to the 'last_cpu_id'.
>>>    * This group utlizes 'count' resources in the 'res'.
>>>    */
>>> -int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>>> +static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
