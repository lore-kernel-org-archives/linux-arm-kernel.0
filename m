From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Nov 2015 11:33:18 -0500
Subject: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
In-Reply-To: <5802577.H74A3Lg5B3@wuerfel>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5638C728.2020503@semihalf.com> <5638CE5D.4030703@codeaurora.org>
 <5802577.H74A3Lg5B3@wuerfel>
Message-ID: <5638E1CE.9000805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/3/2015 10:59 AM, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 10:10:21 Sinan Kaya wrote:
>>
>> I don't see anywhere in the SBSA spec addendum that the PCI
>> configuration space section that unaligned accesses *MUST* be supported.
>>
>> If this is required, please have this info added to the spec. I can work
>> with the designers for the next chip.
>>
>> Unaligned access on the current hardware returns incomplete values or
>> can cause bus faults. The behavior is undefined.
>
> Unaligned accesses are not allowed, but any PCI compliant device must
> support aligned 1, 2 or 4 byte accesses on its configuration space,
> though the byte-enable mechanism. In an ECAM host bridge, those are
> mapped to load/store accesses from the CPU with the respective width
> and natural alignment.
>
> 	Arnd
>

As far as I see, the endpoints do not have any problems with unaligned 
accesses. It is the host bridge itself (stuff that doesn't get on the 
PCIe bus and uses traditional AXI kind bus internally) has problems with 
alignment.

If Linux is expecting all HW vendors to implement alignment support, 
this needs to be put in the SBSA spec as a hard requirement.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
