From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Dec 2013 22:01:28 +0800
Subject: [RFC part2 PATCH 8/9] ACPI / ARM64: Update acpi_register_gsi
 to register with the core IRQ subsystem
In-Reply-To: <201312050448.10312.arnd@arndb.de>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-9-git-send-email-hanjun.guo@linaro.org>
 <201312050448.10312.arnd@arndb.de>
Message-ID: <52A08738.8060701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?05? 11:48, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Hanjun Guo wrote:
>> +       /*
>> +        * ACPI have no bindings to indicate SPI or PPI, so we
>> +        * use different mappings from DT in ACPI.
>> +        *
>> +        * For FDT
>> +        * PPI interrupt: in the range [0, 15];
>> +        * SPI interrupt: in the range [0, 987];
>> +        *
>> +        * For ACPI, using identity mapping for hwirq:
>> +        * PPI interrupt: in the range [16, 31];
>> +        * SPI interrupt: in the range [32, 1019];
> This difference might cause endless confusion. Can't you register PPI and SPI as
> separate IRQ controllers to have the same number space that we normally have?

In ACPI, they used a conception named GSI (Global System Interrupts)
for irq, GSI number can not be the same even if there are muti GICs,
so I use the identity mapping for hwirq for ACPI.

Thanks you very much for your comments :)

Hanjun
