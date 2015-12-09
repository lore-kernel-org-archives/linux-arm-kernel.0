From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 9 Dec 2015 11:41:54 -0600
Subject: [PATCH v5 1/5] acpi: pci: Setup MSI domain for ACPI based pci
 devices
In-Reply-To: <20151209101355.68eab0cc@why.wild-wind.fr.eu.org>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449625686-5594-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151209101355.68eab0cc@why.wild-wind.fr.eu.org>
Message-ID: <566867E2.9040005@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/9/2015 4:13 AM, Marc Zyngier wrote:
> On Tue, 8 Dec 2015 17:48:02 -0800
> Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>
>> This patch introduces pci_msi_register_fwnode_provider() for irqchip
>> to register a callback, to provide a way to determine appropriate MSI
>> domain for a pci device.
>>
>> It also introduces pci_host_bridge_acpi_msi_domain(), which returns
>> the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
>> bus token. Then, it is assigned to pci device.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>>   drivers/pci/pci-acpi.c    | 32 ++++++++++++++++++++++++++++++++
>>   drivers/pci/probe.c       |  2 ++
>>   include/linux/irqdomain.h |  5 +++++
>>   include/linux/pci.h       | 10 ++++++++++
>>   4 files changed, 49 insertions(+)
>>
> [...]
>
> Other than the couple of nits above:
>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>
> 	M.
>

Thanks. I'll take care of them and send out V6.

Suravee
