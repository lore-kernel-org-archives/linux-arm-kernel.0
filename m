From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 18 Apr 2018 09:39:30 -0400
Subject: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
In-Reply-To: <97fc18a7-b321-0039-0413-d461abc2097b@bell.net>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
 <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
 <1523980508.3310.9.camel@HansenPartnership.com>
 <86252a65-265d-e081-b71f-42a0be6b1693@codeaurora.org>
 <97fc18a7-b321-0039-0413-d461abc2097b@bell.net>
Message-ID: <a8c3391d-7109-47bf-e1c4-9217fc68bfd0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2018 6:53 PM, John David Anglin wrote:
> On 2018-04-17 2:28 PM, Sinan Kaya wrote:
>> The correct terminology here would be to use observability. Yes, it can be
>> cached in whatever part of the system for some amount of time as long as
>> PCI device sees it in the correct order.
>>
>> Let's do this exercise.
>> 1. OS writes to memory for some descriptor update
>> 2. OS writes to the device via writel to hit a doorbell
>> 3. Device comes and fetches the memory contents for the descriptor
>>
>> writel() of PA-RISC needs to ensure that 3. cannot bypass 1. This is typically
>> done by a write barrier embedded into the writel() on relaxed architectures.
> The sequence point after the argument evaluation for writel prevents the compiler from reordering
> 1 and 2.? Accesses to I/O space are strongly ordered on PA-RISC, so 1 must occur before 2 (Page G-1
> of the PA-RISC 2.0 Architecture).? Thus, the current code is okay.
> 

Many thanks for the clarification.

> Dave
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
