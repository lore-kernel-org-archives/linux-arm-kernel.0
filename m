From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 11 Feb 2016 15:02:51 +0100
Subject: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
In-Reply-To: <56BC74CA.3020003@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <56BC74CA.3020003@arm.com>
Message-ID: <56BC948B.6030206@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.02.2016 12:47, Marc Zyngier wrote:
> Thomas, Hanjun,
>
> On 19/01/16 13:11, Tomasz Nowicki wrote:
>> Patches base on Suravee's ACPI GICv2m support:
>> https://lkml.org/lkml/2015/12/10/475
>>
>> The following git branch contains submitted patches along with
>> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
>> https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)
>>
>> Series has been tested on Cavium ThunderX server.
>>
>> v2 -> v3
>> - rebased on top of 4.4
>> - fixes and improvements for redistributor init via GICC structures
>> - fixes as per kbuild reports
>>
>> v1 -> v2
>> - rebased on top of 4.4-rc4
>> - use pci_msi_domain_get_msi_rid for requester ID to device ID translation
>>
>> Hanjun Guo (1):
>>    irqchip / GICv3: remove gic root node in ITS
>>
>> Tomasz Nowicki (9):
>>    irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
>>    irqchip / GICv3: Add ACPI support for GICv3+ initialization
>>    irqchip,GICv3,ACPI: Add redistributor support via GICC structures.
>>    irqchip, gicv3, its: Mark its_init() and its children as __init
>>    irqchip, GICv3, ITS: Refator ITS dt init code to prepare for ACPI.
>>    ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
>>    irqchip, gicv3, its: Probe ITS in the ACPI way.
>>    acpi, gicv3, msi: Factor out code that might be reused for ACPI
>>      equivalent.
>>    acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
>>      initialization.
>>
>>   drivers/acpi/Kconfig                     |   3 +
>>   drivers/acpi/Makefile                    |   1 +
>>   drivers/acpi/iort.c                      | 326 +++++++++++++++++++++++++++++
>>   drivers/irqchip/Kconfig                  |   1 +
>>   drivers/irqchip/irq-gic-v3-its-pci-msi.c |  85 ++++++--
>>   drivers/irqchip/irq-gic-v3-its.c         | 143 +++++++++----
>>   drivers/irqchip/irq-gic-v3.c             | 344 ++++++++++++++++++++++++++-----
>>   drivers/pci/msi.c                        |   3 +
>>   include/linux/iort.h                     |  38 ++++
>>   include/linux/irqchip/arm-gic-v3.h       |   2 +-
>>   10 files changed, 845 insertions(+), 101 deletions(-)
>>   create mode 100644 drivers/acpi/iort.c
>>   create mode 100644 include/linux/iort.h
>>
>
> I've so far queued the first 5 patches of this series (basic ACPI
> support for GICv3 and associated cleanups). The rest needs additional
> discussion (see my comments on patch 10), and requires some form of Ack
> from the ACPI maintainers (at least for patch 7).
>
Thanks Marc!

I will respond to the rest of your comments shortly.

Tomasz
