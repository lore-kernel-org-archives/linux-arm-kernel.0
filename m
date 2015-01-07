From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 07 Jan 2015 17:49:25 +0800
Subject: [PATCH v6 01/17] ACPI / processor: Convert apic_id to phys_id
 to make it arch agnostic
In-Reply-To: <1463717.XWsK98imMv@vostro.rjw.lan>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org>
 <1420368918-5086-2-git-send-email-hanjun.guo@linaro.org>
 <1463717.XWsK98imMv@vostro.rjw.lan>
Message-ID: <54AD0125.9060601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?07? 09:50, Rafael J. Wysocki wrote:
> On Sunday, January 04, 2015 06:55:02 PM Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.com>
>>
>> apic_id in MADT table is the CPU hardware id which identify
>> it self in the system for x86 and ia64, OSPM will use it for
>> SMP init to map APIC ID to logical cpu number in the early
>> boot, when the DSDT/SSDT (ACPI namespace) is scanned later, the
>> ACPI processor driver is probed and the driver will use acpi_id
>> in DSDT to get the apic_id, then map to the logical cpu number
>> which is needed by the processor driver.
>>
>> Before ACPI 5.0, only x86 and ia64 were supported in ACPI spec,
>> so apic_id is used both in arch code and ACPI core which is
>> pretty fine. Since ACPI 5.0, ARM is supported by ACPI and
>> APIC is not available on ARM, this will confuse people when
>> apic_id is both used by x86 and ARM in one function.
>>
>> So convert apic_id to phys_id (which is the original meaning)
>> in ACPI processor dirver to make it arch agnostic, but leave the
>> arch dependent code unchanged, no functional change.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> I've queued up this one and [2/17] for 3.19-rc4 as I promised I'd push these
> two for 3.19.

Great, thanks a lot. I thought you will queued them for 3.20 :)

Regards
Hanjun
