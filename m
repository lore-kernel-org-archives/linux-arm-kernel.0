From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 22 Sep 2015 12:02:26 -0700
Subject: [PATCH 3/3] PCI: generic: Add support for Cavium ThunderX PCIe
 root complexes.
In-Reply-To: <20150922185230.GR7356@arm.com>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <1442529694-1792-4-git-send-email-ddaney.cavm@gmail.com>
 <20150922185230.GR7356@arm.com>
Message-ID: <5601A5C2.4030206@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2015 11:52 AM, Will Deacon wrote:
> On Thu, Sep 17, 2015 at 11:41:34PM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The config space for external PCIe root complexes on some Cavium
>> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
>> shift values that have to be applied to the bus and devfn numbers to
>> compose that address window offset.  These root complexes also have
>> the interesting property that there is no root bridge, so the standard
>> manner of limiting scanning to only the first device doesn't work.  We
>> can use the standard pci-host-generic driver if we make a minor
>> addition to handle these differences, so we...
>>
>> Add a mapping function for ThunderX PCIe root complexes with a bus
>> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
>> than the first device on the primary bus.
>>
>> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   .../devicetree/bindings/pci/host-generic-pci.txt   |  8 +++---
>>   drivers/pci/host/pci-host-generic.c                | 29 ++++++++++++++++++++++
>>   2 files changed, 34 insertions(+), 3 deletions(-)
>
> Thanks, this looks better now:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>

Thanks Will.

Because patches 1/3 and 2/3 will be reworked, I will re-send this as a 
stand-alone patch.

David Daney


> Will
>
