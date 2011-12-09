From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 9 Dec 2011 17:48:42 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code checks
 for kprobes.
In-Reply-To: <20111209164029.GL5196@mudshark.cambridge.arm.com>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>
 <20111209155450.GI5196@mudshark.cambridge.arm.com> <4EE234A8.80208@arm.com>
 <20111209164029.GL5196@mudshark.cambridge.arm.com>
Message-ID: <4EE249FA.1060403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/11 16:40, Will Deacon wrote:
 > Hmm, I still don't see why you should change the linkage. Make it
 > static inline if you really want the inline, but that seems weird
 > outside of a header file stub.

OK

>>> Maybe it's best just to change all of the callers to call
>>> arm_check_condition directly, like you have done below for the ARM case. For
>>> the Thumb cases will it work if you make sure that you put the condition
>>> code in the top bits?
>>
>> Yes, that is functionally equivalent, and what I did in the RFC version,
>> but it ended up looking messy at the calling point.
>
> Ok, then could you route the ARM variant through the wrapper too?

I would have preferred the opposite, but that would seem to require more
invasive changes to the Thumb handling code (at least for the
'kprobe_test_flags & TEST_FLAG_NO_ITBLOCK' case). Will do.

/
     Leif

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
