From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 18 Jan 2015 13:49:50 +0800
Subject: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
In-Reply-To: <20150116143337.GA14505@red-moon>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
 <20150116143337.GA14505@red-moon>
Message-ID: <54BB497E.7050606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?16? 22:33, Lorenzo Pieralisi wrote:
> On Wed, Jan 14, 2015 at 03:04:55PM +0000, Hanjun Guo wrote:
>> FADT Major.Minor version was introduced in ACPI 5.1, it is the same
>> as ACPI version.
>>
>> In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
>> MADT table for GIC and SMP init, without those updates, we can not
>> get the MPIDR for SMP init, and GICv2/3 related init information, so
>> we can't boot arm64 ACPI properly with table versions predating 5.1.
>>
>> If firmware provides ACPI tables with ACPI version less than 5.1,
>> OS will be messed up with those information and have no way to init
>
> Nit: "that information"
>
> or
>
> "...OS has no way to retrieve the configuration data that is necessary
> to init SMP boot protocol and the GIC properly, so.."
>
>> smp and GIC, so disable ACPI if we get an FADT table with version
>> less that 5.1.
>>
>
> Patch should be reordered in the series and must be sequenced before
> patch 5 for bisectability (that patch implements DT unflattening if ACPI
> is disabled), or squashed with previous patches.

OK, I will reorder this patch set and update the change log above.

Thanks
Hanjun
