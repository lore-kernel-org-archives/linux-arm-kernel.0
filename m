From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Tue, 05 Oct 2010 17:05:55 -0400
Subject: [RFC] [PATCH] XCHGADD ARM implementation
Message-ID: <4CAB9333.50400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch is the ARM implementation for RWSEM_XCHGADD_ALGORITHM.
Based on David's rwsem benchmark from http://lwn.net/Articles/89191/ ,
I see a consistent 5-6% increase in the number of reads and writes taken as
compared to RWSEM_GENERIC_SPINLOCK on a dual core ARMv7. So far I have tested


numrd=1 numwr=1 numdg=1 do_sched=1

numrd=10 numwr=10 numdg=1 do_sched=1

numrd=20 numwr=20 numdg=1 do_sched=1


Can anyone else help to test this patch on other ARM systems ?

Cheers,
Ashwin



-------------- next part --------------
A non-text attachment was scrubbed...
Name: Optimzed-ARM-RWSEM-algorithm.patch
Type: text/x-patch
Size: 5928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101005/12e3b202/attachment.bin>
