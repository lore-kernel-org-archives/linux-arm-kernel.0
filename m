From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 30 Apr 2015 21:47:13 +0800
Subject: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
In-Reply-To: <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150429140445.GA18867@e104818-lin.cambridge.arm.com>
 <5540EB27.8060507@amd.com>
 <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
Message-ID: <55423261.4050008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?04?29? 22:42, Catalin Marinas wrote:
> On Wed, Apr 29, 2015 at 09:31:03AM -0500, Suravee Suthikulpanit wrote:
>>
>>
>> On 04/29/2015 09:04 AM, Catalin Marinas wrote:
>>> On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit wrote:
>>>>  From ACPIv6 (http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf),
>>>> section 6.2.17 _CCA states that ARM platforms require ACPI _CCA object to be
>>>> specified for DMA-cabpable devices. This patch introduces ACPI_MUST_HAVE_CCA
>>>> in arm and arm64 Kconfig to specify such requirement.
>>>>
>>>> Note that when _CCA is required, if it is missing in the DSDT. ACPI driver
>>>> will default to setting up devices as non-coherent.
>>>>
>>>> Signed-off-by: Mark Salter <msalter@redhat.com>
>>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>> ---
>>>>   arch/arm/Kconfig     | 1 +
>>>>   arch/arm64/Kconfig   | 1 +
>>>>   drivers/acpi/Kconfig | 3 +++
>>>>   3 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 45df48b..2a0d036 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1,6 +1,7 @@
>>>>   config ARM
>>>>   	bool
>>>>   	default y
>>>> +	select ACPI_MUST_HAVE_CCA if ACPI
>>>>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>>>   	select ARCH_HAS_ELF_RANDOMIZE
>>>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>
>>> Any plans for ACPI on 32-bit ARM?
>>
>> Not that I am aware, but I could be totally wrong. The reason I am adding
>> this here for 32-bit ARM is because the ACPI spec mentioned this.
>>
>> If you think this is not necessary until we introduce ACPI for ARM32, it can
>> be removed.
>
> I think it should be removed (as long as ACPI cannot be selected on
> arm32).

I agree.

Now there is no plan for ARM32 ACPI as I know, ACPI for ARM targets
for ARM64 based enterprise system at now.

Thanks
Hanjun
