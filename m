From: awallis@codeaurora.org (Adam Wallis)
Date: Wed, 4 Oct 2017 12:07:52 -0400
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <59C9F74F.2030306@linux.intel.com>
References: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
 <59C9F74F.2030306@linux.intel.com>
Message-ID: <3100d137-d581-665f-9665-561578a61ac8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/2017 2:44 AM, Mathias Nyman wrote:
> On 25.09.2017 19:09, David Laight wrote:
>> From: Adam Wallis
>>> Sent: 25 September 2017 13:26
>>> inc_deq() currently bails earlier for EVENT rings than the common return
>>> point of the function, due to the fact that EVENT rings do not have
>>> link TRBs. The unfortunate side effect of this is that the very useful
>>> trace_xhci_inc_deq() function is not called/usable for EVENT ring
>>> debug.
>>
>> Is it actually worth using different functions for the different
>> ring types?
>> ?From what I remember there are conditionals in a lot of the functions
>> but they are fixed for most of the call sites.
>>
> 
> There's some restructuring and refactoring that could be done in xhci,
> but that's not part of this patch.
> 
> This will just enable better debugging.
> 
> Applying this patch
Sounds great, thanks! Will this be going in on 4.14 sometime shortly? I hadn't
seen it in your tree and was curious since we are tracking internally. Thanks!

> 
> Thanks
> -Mathias


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
