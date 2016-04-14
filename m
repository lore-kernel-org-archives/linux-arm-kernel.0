From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 14 Apr 2016 09:20:45 +0200
Subject: [PATCH V4 4/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
In-Reply-To: <570EB78E.4060705@codeaurora.org>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-5-git-send-email-tn@semihalf.com>
 <570E645A.9010600@arm.com> <570E6794.4080409@semihalf.com>
 <570E6B2C.3060700@arm.com> <570EB78E.4060705@codeaurora.org>
Message-ID: <570F44CD.7090605@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.04.2016 23:18, Sinan Kaya wrote:
> On 4/13/2016 11:52 AM, Marc Zyngier wrote:
>>>> Sure. Please see:
>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
>>>> 3.1.1.5 PCI root complex node
>>>> PCI Segment number -> The PCI segment number, as in MCFG and as
>>>> returned by _SEG in the namespace.
>>>>
>>>> So IORT spec states that pci_segment_number corresponds to the segment
>>>> number from MCFG table and _SEG method. Here is my patch which makes
>>>> sure pci_domain_nr(bus) is set properly:
>>>> https://lkml.org/lkml/2016/2/16/418
>> Lovely. So this series is actually dependent on the PCI one. I guess we
>> need to solve that one first, because IORT seems pretty pointless if we
>> don't have PCI support. What's the plan?
>
> Would it be OK to split the PCI specific section of the patch and continue
> review? PCI is a user of the IORT table. Not the other way around.

I need to disagree. What would be the use case for patches w/o "PCI part" ?

Tomasz
