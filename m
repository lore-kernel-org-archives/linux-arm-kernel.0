From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 2 Jun 2016 11:51:52 +0200
Subject: [PATCH V8 8/9] arm64, pci, acpi: Provide ACPI-specific
 prerequisites for PCI bus enumeration.
In-Reply-To: <20160602094555.GB13962@red-moon>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-9-git-send-email-tn@semihalf.com>
 <20160602094555.GB13962@red-moon>
Message-ID: <575001B8.9020107@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.06.2016 11:45, Lorenzo Pieralisi wrote:
> On Mon, May 30, 2016 at 05:14:21PM +0200, Tomasz Nowicki wrote:
>> ACPI requires to run acpi_pci_{add|remove}_bus while new PCI bus is created.
>> This allows to do some ACPI-specific additional configuration, like
>> PCI hotplug slot enumeration. In order to fulfill these requirements,
>> we implement arch-specific pcibios_{add|remove}_bus calls
>> and call acpi_pci_{add|remove}_bus from there.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   arch/arm64/kernel/pci.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>
> Is there a reason why this has to be a standalone patch ?

No there is no good reason behind this I will squash it with 9.

>
> It is pretty much useless without patch 9 or I have stared at
> this series for too long.

Yes, it is useless w/o patch 9.

>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks,
Tomasz
