From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 20 Oct 2016 20:01:51 -0700
Subject: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
In-Reply-To: <20161021024111.GA24336@localhost>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
 <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost>
 <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
 <20161021024111.GA24336@localhost>
Message-ID: <cf80d0a4-c59d-23ff-081a-cf66feea3563@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2016 7:41 PM, Bjorn Helgaas wrote:
> On Thu, Oct 20, 2016 at 01:01:04PM -0700, Sinan Kaya wrote:
>> On 10/19/2016 3:44 PM, Bjorn Helgaas wrote:
> 
>>>   - Maintain a mapping of (IRQ, penalty).  Initially all penalties are
>>>     zero.  This is for *all* IRQs, not just ISA ones.  This could be a
>>>     linked list, but the structure is not important as long as we can
>>>     add things dynamically.
>>
>> Dynamic allocation doesn't work due to early calls from x86 architecture.
>> This is the reason why we iterate the link objects.
> 
> Where exactly is this early penalization?  That seems to be the
> biggest problem.  Well, maybe the question of ACPI core parsing of
> _CRS/_PRS is a bigger structural problem, but the dynamic allocation
> thing at least seems solvable.
> 

http://marc.info/?l=linux-acpi&m=145580159209240&w=2


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
