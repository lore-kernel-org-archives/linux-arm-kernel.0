From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 28 Feb 2018 16:20:45 +0000
Subject: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19101C8A7@SHSMSX101.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
 <b3c190e7-1a33-971e-b86c-a9725118ba05@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191003B1B@SHSMSX101.ccr.corp.intel.com>
 <0b579768-3090-dd50-58b1-3385be92ef21@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19101C8A7@SHSMSX101.ccr.corp.intel.com>
Message-ID: <f3de53ca-0c3f-47f4-d77b-cf3d9bfd3da6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/18 06:21, Tian, Kevin wrote:
[...]
>> Technically nothing prevents it, but now the resv problem discussed on
>> patch 2/37 stands out. For example on x86 you'd probably need to carve
>> the
>> IOAPIC MSI range out of the process address space. On Arm you'd need to
>> create a write-only mapping for MSIs (IOMMU translates it to the IRQ chip
>> address, but thankfully accessing the doorbell from CPU side doesn't
>> trigger an MSI.)
> 
> so if overlap already exists when binding a process address space
> (since binding may happen much later than creating the process),
> I assume the call will simply fail since carve out at this point is not
> possible?

Yes in this case I think it's safer to abort the bind() call

Thanks,
Jean
