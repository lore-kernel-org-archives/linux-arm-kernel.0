From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 5 Mar 2015 15:03:32 +0800
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <12535711.Yi1RhU69kM@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <12535711.Yi1RhU69kM@vostro.rjw.lan>
Message-ID: <54F7FFC4.9070107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 6:56, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 04:39:40 PM Hanjun Guo wrote:
>> Changes since v8:
>>   - remove MPIDR packing things by introducing phys_cpuid_t;
>>
>>   - update patch acpi: fix acpi_os_ioremap for arm64 to follow
>>     Rafael's suggestion;
>>
>>   - Squash patch (disable ACPI if ACPI less than 5.1) to patch
>>     (Get RSDP and ACPI boot-time table);
>>
>>   - Move sleep_arm.c to arch/arm64/ and rename it as acpi_sleep.c 
>>
>>   - Rework the uefi generated empty dtb to enable acpi when no dtb
>>     is available, thanks Ard for the updated patch.
>>
>>   - rework the function of register cpu for kexec case
>>
>>   - use pr_debug() instead of pr_info() when scanning MADT.
>>
>>   - rebase on top of 4.0-rc1
>>
>> Thanks
>> Hanjun
>>
>> Al Stone (4):
>>   ARM64 / ACPI: Get RSDP and ACPI boot-time tables
>>   ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI
>>   ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
>>     ARM64
>>   ARM64 / ACPI: additions of ACPI documentation for arm64
>>
>> Graeme Gregory (6):
>>   ACPI: add arm64 to the platforms that use ioremap
>>   ACPI / sleep: Introduce arm64 specific acpi_sleep.c
>>   ARM64 / ACPI: If we chose to boot from acpi then disable FDT
>>   ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
>>   ARM64 / ACPI: Enable ARM64 in Kconfig
>>   Documentation: ACPI for ARM64
>>
>> Hanjun Guo (8):
>>   ACPI / table: Use pr_debug() instead of pr_info() for MADT table
>>     scanning
>>   ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID
>>   ARM64 / ACPI: Introduce PCI stub functions for ACPI
>>   ACPI / table: Print GIC information when MADT is parsed
>>   ARM64 / ACPI: Parse MADT for SMP initialization
>>   ACPI / processor: Make it possible to get CPU hardware ID via GICC
>>   ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
>>   clocksource / arch_timer: Parse GTDT to initialize arch timer
>>
>> Mark Salter (2):
>>   ARM64: allow late use of early_ioremap
>>   ACPI: fix acpi_os_ioremap for arm64
>>
>> Tomasz Nowicki (1):
>>   irqchip: Add GICv2 specific ACPI boot support
> I've ACKed or commented the ones relevant for me.  As for the ARM64-specific
> code, I don't think I can give any meaningful input.

Hi Rafael, thank you very much for the ACKs and review comments, I will
wait for other maintainers comments and then update this patch set.

Regards
Hanjun
