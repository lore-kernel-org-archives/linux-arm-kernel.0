From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 25 Sep 2017 13:03:58 -0400
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
References: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD007F5A1@AcuExch.aculab.com>
Message-ID: <11eaa02a-228a-09de-5d89-4fce32236253@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/25/2017 12:09 PM, David Laight wrote:
> From: Adam Wallis
>> Sent: 25 September 2017 13:26
>> inc_deq() currently bails earlier for EVENT rings than the common return
>> point of the function, due to the fact that EVENT rings do not have
>> link TRBs. The unfortunate side effect of this is that the very useful
>> trace_xhci_inc_deq() function is not called/usable for EVENT ring
>> debug.
> 
> Is it actually worth using different functions for the different
> ring types?

David, that is what this patch attempts to add/fix. Instead of adding another
TRACE function for event rings, it hooks the existing trace functionality
already used in inc_deq()

> From what I remember there are conditionals in a lot of the functions
> but they are fixed for most of the call sites.

That's basically all this patch is...fixing a conditional. Thanks for the
feedback, let me know if I misunderstood your comments!

> 
> 	David
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
